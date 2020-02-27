# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Surveys::SurveysController.class_eval do
    include ApplicationHelper

    # allow many responses to this questionnaire
    def visitor_already_answered?
      answered = questionnaire.answered_by?(current_user || tokenize(session[:session_id]))
      return answered unless timetracker_survey == survey
      false
    end

    # generate a new token always for this questionnaire
    def tokenize(id)
      token = Digest::MD5.hexdigest("#{id}-#{Rails.application.secrets.secret_key_base}")
      return token unless timetracker_survey == survey
      "#{id} #{Time.current}"
    end
  end

  Decidim::Forms::QuestionnaireUserAnswers.class_eval do
    include ApplicationHelper

    # ensure this query is always based on session_token
    def query
      answers = Decidim::Forms::Answer.where(questionnaire: @questionnaire)
      hacked = timetracker_hacked_surveys.map(&:questionnaire)
      if hacked.include? @questionnaire
        return answers.sort_by { |answer| answer.question.position }.group_by { |a| a.session_token }.values
      end
      answers.sort_by { |answer| answer.question.position }.group_by { |a| a.user || a.session_token }.values
    end
  end
end