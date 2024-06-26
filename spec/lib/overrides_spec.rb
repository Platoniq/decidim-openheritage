# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-admin",
    files: {
      "/app/views/decidim/admin/static_pages/index.html.erb" => "0244901bd7ad503ef24f3a6c6786a84d"
    }
  },
  {
    package: "decidim-conferences",
    files: {
      "/app/views/layouts/decidim/_conference_hero.html.erb" => "8cc0001a365b4659306a21a961a4249b",
      "/app/views/decidim/conferences/conferences/show.html.erb" => "2b158a066257f7a8d0b30cb6987dd45c"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "95f4f9e7c82f6c37f9c07f8c53f438b7"
    }
  },
  {
    package: "decidim-pages",
    files: {
      "/app/views/decidim/pages/application/show.html.erb" => "69a1ceb1bcb6b241ec68d7c81dcf6551"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/models/decidim/participatory_process.rb" => "a20f46b5f0fa44c5f033d5a3152efa92"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "e95e244e99bba07303e6b94856d42cb4"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "f443ed19838d251fd9d9b960e5908418"
    }
  },
  {
    package: "decidim-core",
    files: {
      # views
      "/app/views/decidim/pages/index.html.erb" => "4606c1811c709bd3b81f75aaaf8f830e",

      # layouts
      "/app/views/layouts/decidim/_head_extra.html.erb" => "1b8237357754cf519f4e418135f78440",
      "/app/views/layouts/decidim/_mini_footer.html.erb" => "5a842f3e880f24f49789ee2f72d96f60",
      "/app/views/layouts/decidim/mailer.html.erb" => "0c7804de08649c8d3c55c117005e51c9"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    # rubocop:disable Rails/DynamicFindBy
    spec = ::Gem::Specification.find_by_name(item[:package])
    # rubocop:enable Rails/DynamicFindBy
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
