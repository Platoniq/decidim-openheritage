# frozen_string_literal: true

module Decidim
  module Forms
    module ResponseQuestionnaireOverride
      extend ActiveSupport::Concern

      included do
        # Allow users to respond a survey multiple times
        # Necessary for timetracker functionality
        def call
          return broadcast(:invalid) if @form.invalid?

          with_events do
            clear_responses! if allow_editing_responses
            response_questionnaire
          end

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
