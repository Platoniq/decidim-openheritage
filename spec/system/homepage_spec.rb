# frozen_string_literal: true

require "rails_helper"
require "decidim/surveys/test/factories"

describe "Visit the home page", :perform_enqueued do # rubocop:disable RSpec/DescribeClass
  let(:organization) { create(:organization, external_domain_whitelist: ["decidim.org", "openheritage.eu", "wikipedia.org"]) }
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
      tenants: tenants
    }
  end
  let(:tenants) { nil }
  let(:openheritage) { nil }
  let(:timetracker) { nil }

  before do
    switch_to_host(organization.host)
    allow(Rails.application.secrets).to receive_messages(menu: menu, matomo: matomo, openheritage: openheritage, timetracker: timetracker)
    visit decidim.root_path
  end

  it "renders the home page" do
    expect(page).to have_content("Home")
  end

  it "has a custom menu" do
    within ".main-nav" do
      expect(page).to have_link("Translation missing: en.i18n_key", href: "http://www.wikipedia.org")
    end
  end

  context "when matomo is configured" do
    it "has matomo trackers" do
      within "#matomo-script", visible: false do
        expect(page.body).to include("var u='http://matomo.lvh.me/'")
        expect(page.body).to include("_paq.push(['setSiteId', '123']);")
        expect(page.body).not_to include("_paq.push(['setSiteId', '987']);")
      end
    end

    context "when matomo is customized for the tenant" do
      let(:tenants) do
        {
          organization.host.to_sym => 987
        }
      end

      it "has matomo trackers" do
        within "#matomo-script", visible: false do
          expect(page.body).to include("var u='http://matomo.lvh.me/'")
          expect(page.body).not_to include("_paq.push(['setSiteId', '123']);")
          expect(page.body).to include("_paq.push(['setSiteId', '987']);")
        end
      end
    end
  end

  context "when openheritage tenant" do
    let(:openheritage) { [organization.host] }

    it "has EU footer" do
      within ".eu-footer" do
        expect(page).to have_content("This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 776766")
      end
      within ".mini-footer" do
        expect(page).to have_link(href: "https://openheritage.eu/")
      end
    end
  end

  context "when platoniq tenant" do
    it "has platoniq footer" do
      expect(page).to have_no_css(".eu-footer")
      within ".mini-footer" do
        expect(page).to have_link(href: "https://decidim.org/")
      end
    end
  end

  context "when using surveys" do
    let(:manifest_name) { "surveys" }

    let(:user) { create(:user, :confirmed, organization: component.organization) }
    let!(:questionnaire) { create(:questionnaire) }
    let!(:survey) { create(:survey, component: component, questionnaire: questionnaire) }
    let!(:question) { create(:questionnaire_question, questionnaire: questionnaire, position: 0) }

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

      expect(page).to have_i18n_content(questionnaire.title, upcase: true)
      expect(page).to have_i18n_content(questionnaire.description)

      fill_in question.body["en"], with: "My first answer"

      check "questionnaire_tos_agreement"

      accept_confirm do
        click_on "Submit"
      end

      within ".success.flash" do
        expect(page).to have_content("successfully")
      end

      visit_component

      expect(page).to have_content("You have already answered this form.")
      expect(page).to have_no_i18n_content(question.body)
    end

    context "and is listed as a timetracker" do
      let(:timetracker) do
        {
          components: [component.id]
        }
      end

      it "allows multiple answers" do
        visit_component

        expect(page).to have_i18n_content(questionnaire.title, upcase: true)
        expect(page).to have_i18n_content(questionnaire.description)

        fill_in question.body["en"], with: "My first answer"

        check "questionnaire_tos_agreement"

        accept_confirm do
          click_on "Submit"
        end

        within ".success.flash" do
          expect(page).to have_content("successfully")
        end

        visit_component

        expect(page).to have_no_content("You have already answered this form.")
        expect(page).to have_i18n_content(question.body)

        fill_in question.body["en"], with: "My first answer"

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
