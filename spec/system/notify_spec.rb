# frozen_string_literal: true

require "rails_helper"
require "decidim/notify/test/factories"

describe "Visit a notify component", :perform_enqueued do # rubocop:disable RSpec/DescribeClass
  let(:organization) { create(:organization) }
  let(:participatory_process) { create(:participatory_process, organization: organization) }
  let(:component) { create(:notify_component, participatory_space: participatory_process) }

  before do
    switch_to_host(organization.host)
    page.visit main_component_path(component)
  end

  it "renders notify view" do
    expect(page).to have_content("Note Takers")
  end
end
