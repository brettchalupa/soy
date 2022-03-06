# frozen_string_literal: true

require "spec_helper"

RSpec.describe "soy new" do
  def clean_up(dir)
    FileUtils.rm_rf(dir)
  end

  let(:site_name) { "new_site" }

  before { clean_up(site_name) }

  after { clean_up(site_name) }

  it "generates a new site from the template" do
    output = run_cmd("new #{site_name}")

    expect(output).to match(/New Soy site created, view in: new_site/)

    [".gitignore", "content/index.html.erb", "views/layout.html.erb", "content/styles.css"].each do |file|
      expect(File.read("new_site/#{file}")).to eql(File.read("lib/soy/template/#{file}"))
    end

    expect(File.read("new_site/.gitignore")).to match(/build/)
  end
end
