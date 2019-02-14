if Rails.env.production?
  Decidim.configure do |config|

	# Max requests in a time period to prevent DoS attacks. Only applied on production.
	config.throttling_max_requests = 100

	# Time window in which the throttling is applied.
	config.throttling_period = 1.minute

  end
end

# Provided that trusted users use an HTTP request header named APIKey
Rack::Attack.safelist("mark any authenticated access safe") do |request|
  # Requests are allowed if the return value is truthy
  request.env["APIKey"] == Rails.application.secrets.rack_attack_apikey || "let-me-hack"
end