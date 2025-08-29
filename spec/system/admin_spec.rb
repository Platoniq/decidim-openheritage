# frozen_string_literal: true

require "rails_helper"

describe "Visit the signup page", :perform_enqueued do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization:) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.root_path
  end

  it "renders the dashboard page" do
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("See site")
  end

  it "renders the processes page" do
    click_on "Processes"
    within ".layout-content" do
      expect(page).to have_content("Processes")
    end
  end

  it "renders the assemblies page" do
    click_on "Assemblies"
    within ".process-title-content-breadcrumb" do
      expect(page).to have_content("Assemblies")
    end
    within ".process-title-content-breadcrumb-container-right-link" do
      expect(page).to have_content("New assembly")
    end
  end

  it "renders global moderations" do
    click_on "Global moderations"
    within ".layout-content" do
      expect(page).to have_content("Reported content")
    end
  end

  it "renders pages" do
    click_on "Pages"
    within ".layout-content" do
      expect(page).to have_content("Pages")
    end
  end

  it "renders newsletters" do
    click_on "Newsletters"
    within ".layout-content" do
      expect(page).to have_content("Newsletters")
    end
  end

  it "renders settings" do
    click_on "Settings"
    within ".layout-content" do
      expect(page).to have_content("Edit organization")
    end
  end

  it "renders Decidim awesome" do
    click_on "Decidim awesome"
    within ".layout-content" do
      expect(page).to have_content("Tweaks for Editor Hacks")
    end
  end

  it "renders admin activity log" do
    click_on "Admin activity log"
    within ".layout-content" do
      expect(page).to have_content("Admin log")
    end
  end

  it "renders templates" do
    click_on "Templates"
    within ".layout-content" do
      expect(page).to have_content("Templates")
    end
  end
end
