# frozen_string_literal: true

require "rails_helper"

describe "conference with images", type: :system do
  let!(:organization) { create :organization }
  let!(:conference) { create :conference, organization: organization, slug: slug, registrations_enabled: true }
  let(:slug) { "bla-bla" }
  let(:user) { create(:user, :confirmed, organization: organization) }

  before do
    visit_component
    page.execute_script("$('#dc-modal-accept').click()")
    visit Decidim::ResourceLocatorPresenter.new(post).path
  end

  it "shows the image" do
    expect(page).to have_selector('img src=')
  end
end
