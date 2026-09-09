# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Surveys::SurveysController.class_eval do
    include ApplicationHelper

    # allow many responses to this questionnaire
    def visitor_already_responded?
      responded = questionnaire.responded_by?(current_user || tokenize(session[:session_id]))
      return responded unless timetracker_survey == survey

      false
    end

    # generate a new token always for this questionnaire
    def tokenize(id, length: 10)
      tokenizer = Decidim::Tokenizer.new(salt: questionnaire.salt || questionnaire.id, length:)
      return tokenizer.int_digest(id).to_s unless timetracker_survey == survey

      "#{id} #{Time.current}"
    end
  end

  Decidim::Forms::QuestionnaireUserResponses.class_eval do
    include ApplicationHelper

    # ensure this query is always based on session_token
    def query
      responses = Decidim::Forms::Response.not_separator
                                          .not_title_and_description
                                          .joins(:question)
                                          .where(questionnaire: @questionnaire)
      hacked = timetracker_hacked_surveys.map(&:questionnaire)
      return responses.sort_by { |response| response.question.position.to_i }.group_by(&:session_token).values if hacked.include? @questionnaire

      responses.sort_by { |response| response.question.position.to_i }.group_by { |r| r.user || r.session_token }.values
    end
  end
end
