# frozen_string_literal: true

require "rails_helper"
require "decidim/surveys/test/factories"

describe "Visit the home page", :perform_enqueued do
  let(:organization) { create(:organization, external_domain_allowlist: ["decidim.org", "openheritage.eu", "wikipedia.org"]) }
  let(:menu) do
    {
      organization.host.to_sym =>
      {
        test:
        {
          key: "i18n_key",
          url: "http://www.wikipedia.org",
          position: 3
        }
      }
    }
  end
  let(:matomo) do
    {
      id: 123,
      url: "http://matomo.lvh.me/",
      tenants:
    }
  end
  let(:tenants) { nil }
  let(:openheritage) { nil }
  let(:timetracker) { nil }

  before do
    switch_to_host(organization.host)
    allow(Rails.application.secrets).to receive_messages(menu:, matomo:, openheritage:, timetracker:)
    visit decidim.root_path
  end

  it "renders the home page" do
    expect(page).to have_content("Home")
  end

  it "has a custom menu" do
    within "nav[role='navigation']", text: "Translation missing: en.i18n_key" do
      expect(page).to have_link("Translation missing: en.i18n_key", href: "http://www.wikipedia.org")
    end
  end  

  context "when openheritage tenant" do
    let(:openheritage) { [organization.host] }

    it "has EU footer" do
      within ".eu-footer" do
        expect(page).to have_content("This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 776766")
      end
    end
  end

  context "when using surveys" do
    let(:first_type) { "short_answer" }
    let!(:first) do
      create(:questionnaire_question, questionnaire:, position: 1, question_type: first_type)
    end
    let(:manifest_name) { "surveys" }

    let(:user) { create(:user, :confirmed, organization: component.organization) }
    let!(:questionnaire) { create(:questionnaire, skip_injection: true) }
    let!(:survey) { create(:survey, component:, questionnaire:, starts_at: 1.day.ago, ends_at: 1.month.from_now, allow_answers: true, published_at: 1.day.ago, skip_injection: true) }
    let!(:answer) { create(:answer, questionnaire:, question: first) }

    include_context "with a component"
    before do
      component.update!(
        step_settings: {
          component.participatory_space.active_step.id => {
            allow_answers: true
          }
        }
      )
      login_as user, scope: :user
    end

    it "allows only one answer" do
      visit_component

      expect(page).to have_i18n_content(questionnaire.title)

      current_locale = I18n.locale.to_s
      description_text = questionnaire.description[current_locale]
      sanitized_description = ActionView::Base.full_sanitizer.sanitize(description_text)

      click_on questionnaire.title[current_locale]

      expect(page).to have_i18n_content(sanitized_description)

      fill_in questionnaire.questions.first.body["en"], with: "My first answer"

      check "questionnaire_tos_agreement"

      accept_confirm do
        click_on "Submit"
      end

      within ".success.flash" do
        expect(page).to have_content("successfully")
      end

      visit_component
      click_on questionnaire.title[current_locale]

      expect(page).to have_content("You have already answered this form.")
      expect(page).to have_no_i18n_content(questionnaire.questions.first.body)
    end

    context "and is listed as a timetracker" do
      let(:timetracker) do
        {
          components: [component.id]
        }
      end

      it "allows multiple answers" do
        visit_component

        expect(page).to have_i18n_content(questionnaire.title)

        current_locale = I18n.locale.to_s
        description_text = questionnaire.description[current_locale]
        sanitized_description = ActionView::Base.full_sanitizer.sanitize(description_text)

        click_on questionnaire.title[current_locale]

        expect(page).to have_i18n_content(sanitized_description)

        fill_in questionnaire.questions.first.body["en"], with: "My first answer"

        check "questionnaire_tos_agreement"

        accept_confirm do
          click_on "Submit"
        end

        within ".success.flash" do
          expect(page).to have_content("successfully")
        end

        visit_component
        click_on questionnaire.title[current_locale]

        expect(page).to have_no_content("You have already answered this form.")
        expect(page).to have_i18n_content(questionnaire.questions.first.body)

        fill_in questionnaire.questions.first.body["en"], with: "My first answer"

        check "questionnaire_tos_agreement"

        accept_confirm do
          click_on "Submit"
        end

        within ".success.flash" do
          expect(page).to have_content("successfully")
        end
      end
    end
  end
end
