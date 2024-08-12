# frozen_string_literal: true

require "rails_helper"

describe "Conference with images", type: :system do
  let(:organization) { create :organization }
  let(:short_description) { { en: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><img src=\"img.png\">" } }
  let(:conference) { create :conference, organization: organization, short_description: short_description }

  before do
    switch_to_host(organization.host)
    page.visit "/conferences/#{conference.slug}"
  end

  it "shows the image" do
    expect(page).to have_selector("img")
  end
end
