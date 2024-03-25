# frozen_string_literal: true

module Decidim
  module Forms
    module AnswerQuestionnaireOverride
      extend ActiveSupport::Concern

      included do
        # Answers a questionnaire if it is valid
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if @form.invalid?

          answer_questionnaire

          if @errors
            reset_form_attachments
            broadcast(:invalid)
          else
            broadcast(:ok)
          end
        end
      end
    end
  end
end
