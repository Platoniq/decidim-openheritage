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
      "/app/views/decidim/conferences/conferences/show.html.erb" => "d8244b43d93c792962b2114f6e488b09"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_responses.rb" => "d9a56ef2b9b1e06040143272adf8d7d0",
      "/app/commands/decidim/forms/response_questionnaire.rb" => "bccc2b66b74ea438ce3364c5bbbfca79"
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
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "f72e142e4ca46c2d77f5041175dd4faf"
    }
  },
  {
    package: "decidim-core",
    files: {
      # footer
      "/app/views/layouts/decidim/footer/_mini.html.erb" => "c67cc97db27cdcf926f60682e399f688",

      # views
      "/app/views/decidim/pages/index.html.erb" => "37c8c372c418138c33671b2fae65ba50",

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
