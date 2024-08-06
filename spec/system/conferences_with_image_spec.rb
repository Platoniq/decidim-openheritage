# frozen_string_literal: true

require "rails_helper"
require "decidim/conferences/test/factories"

describe "Conference with images", type: :system, perform_enqueued: true do
  let!(:organization) { create :organization }
  let!(:conference) { create :conference, organization: organization, slug: slug, registrations_enabled: true }
  let(:slug) { "bla-bla" }
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
