# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-admin",
    files: {
      "/app/views/decidim/admin/static_pages/index.html.erb" => "debf4d3ae461c4c827f8e3242c6e8727"
    }
  },
  {
    package: "decidim-conferences",
    files: {
      "/app/views/decidim/conferences/conferences/_conference_hero.html.erb" => "c49e3bfd348285ea3fcd6abcd00cf350",
      "/app/views/decidim/conferences/conferences/show.html.erb" => "16ff68b3c8208f93813f8f6354528c17"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_responses.rb" => "d9a56ef2b9b1e06040143272adf8d7d0",
      "/app/commands/decidim/forms/response_questionnaire.rb" => "dcac7f5ad0ab6010d6ebdad0e5ae4db2"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/models/decidim/participatory_process.rb" => "7a5d16b62827f11d3c15719fdb2a068b"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "e2c0adf5c283f7396d93207e1b7ab740"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "78f245485d5c50e6a51a15c30452f5c7"
    }
  },
  {
    package: "decidim-core",
    files: {
      # footer
      "/app/views/layouts/decidim/footer/_mini.html.erb" => "c67cc97db27cdcf926f60682e399f688",

      # views
      "/app/views/decidim/pages/index.html.erb" => "1f4f2c100cd9c24d3368218e6a71a1e5",

      # layouts
      "/app/views/layouts/decidim/mailer.html.erb" => "6a08103c75e5db737a38cd365428a177",
      "/app/views/devise/mailer/invite_private_user.html.erb" => "f978eddb05fa55af2c33ce78c964a2bb"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])
    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
