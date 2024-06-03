# frozen_string_literal: true

module CustomConferenceRegistrationHelper
  ENV_PREFIX = "CONFERENCE_REGISTRATION_PATH"

  def has_custom_registration?(conference)
    custom_registration_path(conference).present?
  end

  def custom_registration_path(conference)
    ENV.fetch([ENV_PREFIX, constantize_slug(conference.slug)].join("_"), nil)
  end

  def conference_registration_path(conference)
    if has_custom_registration?(conference)
      custom_registration_path(conference)
    else
      decidim_conferences.conference_registration_types_path(conference)
    end
  end

  def constantize_slug(slug)
    slug.underscore.upcase
  end
end
