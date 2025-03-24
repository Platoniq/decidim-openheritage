# frozen_string_literal: true

require "rails_helper"
require "decidim/conferences/test/factories"

describe "Visit a conference", :perform_enqueued do # rubocop:disable RSpec/DescribeClass
  let!(:organization) { create(:organization) }
  let!(:conference) { create(:conference, organization: organization, slug: slug, registrations_enabled: true) }
  let(:slug) { "bla-bla" }
  let(:user) { create(:user, :confirmed, organization: organization) }

  CUSTOM_PATH = "/bla"

  shared_examples_for "renders registration links" do |path|
    it "renders the registration link in the hero" do
      within ".hero__container" do
        expect(page).to have_link("Register", href: path)
      end
    end

    it "renders the registration link twice in the page" do
      within ".wrapper" do
        expect(page).to have_link("Register", href: path, count: 2)
      end
    end
  end

  context "when registrations are enabled" do
    context "and there is a survey for registrations" do
      before do
        ENV["CONFERENCE_REGISTRATION_PATH_BLA_BLA"] = CUSTOM_PATH
        switch_to_host(organization.host)
        sign_in user
        page.visit "/conferences/bla-bla"
      end

      it_behaves_like "renders registration links", CUSTOM_PATH
    end

    context "and there is no custom survey for registrations" do
      before do
        ENV["CONFERENCE_REGISTRATION_PATH_BLA_BLA"] = nil
        switch_to_host(organization.host)
        sign_in user
        page.visit "/conferences/bla-bla"
      end

      it_behaves_like "renders registration links", "/conferences/bla-bla/registration"
    end
  end
end
