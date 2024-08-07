# frozen_string_literal: true

require "rails_helper"
require "decidim/conferences/test/factories"

describe "Conference with images", type: :system do
  include_context "with a component"
  let!(:organization) { create :organization }
  let(:slug) { "bla-bla" }
  let(:body) { { en: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><img src=\"img.png\">" } }
  let!(:conference) { create :conference, organization: organization, slug: slug, registrations_enabled: true, component: component, body: body }
  let(:user) { create(:user, :confirmed, organization: organization) }

  before do
    visit_component
    page.execute_script("$('#dc-modal-accept').click()")
    page.visit "/conferences/bla-bla"
  end

  it "shows the image" do
    expect(page).to have_selector("img")
  end
end
