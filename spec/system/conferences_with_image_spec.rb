# frozen_string_literal: true

require "rails_helper"

describe "Conference with images" do
  let(:organization) { create(:organization) }
  let(:short_description) { { en: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><img src=\"/favicon.ico\">" } }
  let!(:conference) { create(:conference, organization:, short_description:) }

  before do
    switch_to_host(organization.host)
    page.visit "/conferences/#{conference.slug}"
  end

  it "shows the image" do
    within "#content" do
      expect(page).to have_xpath("//img[contains(@src,'favicon.ico')]")
    end
  end
end
