# frozen_string_literal: true

module SurveyConferenceRegistrationHelper
  def has_survey_registration?(conference)
    survey_registration_path(conference).present?
  end

  def survey_registration_path(conference)
    ENV["CONFERENCE_REGISTRATION_PATH_#{constantize_slug(conference.slug)}"]
  end

  def conference_registration_path(conference)
    if has_survey_registration?(conference)
      survey_registration_path(conference)
    else
      decidim_conferences.conference_registration_types_path(conference)
    end
  end

  def constantize_slug(slug)
    slug.underscore.upcase
  end
end
