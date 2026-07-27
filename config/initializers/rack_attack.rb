# frozen_string_literal: true

# Protects the endpoints being hammered by bots (see AppSignal):
# - Decidim::Comments::CommentsController#index (/comments)
# - Decidim::UserActivitiesController#index (/profiles/:nickname/activity)
class Rack::Attack
  # Uses Rails.cache (Redis in production) to count requests across processes

  ### Throttle comments polling: /comments?commentable_gid=...
  throttle("comments/ip", limit: 30, period: 1.minute) do |req|
    req.ip if req.get? && req.path.start_with?("/comments")
  end

  PROFILE_SUBPAGES = %r{\A/profiles/[^/]+/(activity|following|followers|badges)}

  ### Throttle profile activity pagination: /profiles/:nickname/activity
  throttle("profile_activity/ip", limit: 30, period: 1.minute) do |req|
    req.ip if req.get? && req.path.match?(PROFILE_SUBPAGES)
  end

  # Legit traffic to these endpoints comes from users browsing our own pages,
  # so the browser always sends a same-site Referer (comments are fetched via
  # AJAX from proposal/meeting pages; activity pagination is clicked from the
  # profile). Distributed crawlers hit the URLs directly, with no Referer or a
  # foreign one — so refererless traffic can be capped globally without
  # affecting normal users, even when the crawl rotates IPs and user agents.
  def self.no_own_referer?(req)
    referer = req.get_header("HTTP_REFERER")
    referer.nil? || URI.parse(referer).host != req.host
  rescue URI::InvalidURIError
    true
  end

  throttle("profile_activity/no_referer", limit: 60, period: 1.minute) do |req|
    "global" if req.get? && req.path.match?(PROFILE_SUBPAGES) && no_own_referer?(req)
  end

  throttle("comments/no_referer", limit: 60, period: 1.minute) do |req|
    "global" if req.get? && req.path.start_with?("/comments") && no_own_referer?(req)
  end

  ### Block well-known scraper/AI crawlers outright on these endpoints
  BLOCKED_UA = /Bytespider|PetalBot|Amazonbot|ClaudeBot|GPTBot|CCBot|DataForSeoBot|SemrushBot|AhrefsBot|MJ12bot/i
  blocklist("bad_bots") do |req|
    req.user_agent&.match?(BLOCKED_UA) &&
      (req.path.start_with?("/comments") || req.path.start_with?("/profiles/"))
  end

  # Respond with 429 and a Retry-After hint instead of the default 403 for throttles
  self.throttled_responder = lambda do |request|
    match_data = request.env["rack.attack.match_data"]
    retry_after = match_data ? match_data[:period] : 60
    [429, { "Content-Type" => "text/plain", "Retry-After" => retry_after.to_s }, ["Too many requests. Please slow down.\n"]]
  end
end

ActiveSupport::Notifications.subscribe("throttle.rack_attack") do |_name, _start, _finish, _id, payload|
  req = payload[:request]
  Rails.logger.warn("[rack-attack] throttled #{req.ip} #{req.request_method} #{req.fullpath} UA=#{req.user_agent}")
end
