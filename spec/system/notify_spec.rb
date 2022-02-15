# frozen_string_literal: true

require "rails_helper"

describe "Visit a notify component", type: :system, perform_enqueued: true do
  let(:organization) { create :organization }
  let(:participatory_process) { create :participatory_process, organization: organization }
  let(:component) { create :component, manifest_name: :notify, participatory_space: participatory_process }

  before do
    switch_to_host(organization.host)
    page.visit main_component_path(component)
  end

  it "jmioerfg" do
    expect(page).to have_content("Note Takers")
  end
end
