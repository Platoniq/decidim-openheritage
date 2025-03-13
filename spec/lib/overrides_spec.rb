# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-admin",
    files: {
      "/app/views/decidim/admin/static_pages/index.html.erb" => "397b264a6627abd514b90f3b2d1cd1a9"
    }
  },
  {
    package: "decidim-conferences",
    files: {
      "/app/views/decidim/conferences/conferences/_conference_hero.html.erb" => "7bf25408e38deeb9c975476ef8c1d219",
      "/app/views/decidim/conferences/conferences/show.html.erb" => "93fa0d48a6117d3b1cb210ad1f17da7e"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "fb14ed5f570c6d18e5d0d83808d03b5d",
      "/app/commands/decidim/forms/answer_questionnaire.rb" => "04911ecd2621f959f512b34e4dd9ab3f"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/models/decidim/participatory_process.rb" => "1310bed66aa264c3833f9ec01ee14c21"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "1c43824df4e84de47111e86d3193efd1"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "161ca4167c381f3ba93d86431c10710b"
    }
  },
  {
    package: "decidim-core",
    files: {
      # footer
      "/app/views/layouts/decidim/footer/_mini.html.erb" => "cf7e273390b5a94b7df7167e37038ec4",

      # views
      "/app/views/decidim/pages/index.html.erb" => "ab24999a330e6ff34b1851a01ce56cc6",

      # layouts
      "/app/views/layouts/decidim/_head_extra.html.erb" => "1b8237357754cf519f4e418135f78440",
      "/app/views/layouts/decidim/mailer.html.erb" => "4e308c82acd8b1dac405ff71963d8743"
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
