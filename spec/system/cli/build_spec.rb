# frozen_string_literal: true

require "spec_helper"

RSpec.describe "soy build" do
  let(:fixture_dir) { "spec/fixtures/site" }
  let(:build_dir) { "#{fixture_dir}/build" }

  before { FileUtils.rm_rf(build_dir) }

  it "generates the site" do
    cmd_output = run_cmd("build #{fixture_dir}")
    expect(cmd_output).to match(/Building site/)
    expect(cmd_output).to match(/built in \d.\d+ seconds/)

    html_output = <<~HTML
      <html>
        <head>
          <title>Hello, world!</title>
        </head>
        <body>

      <h1>Hello from Soy</h1>

        </body>
      </html>
    HTML

    expect(File.read("#{build_dir}/index.html")).to eql(html_output)
  end

  it "supports the b alias" do
    cmd_output = run_cmd("b #{fixture_dir}")
    expect(cmd_output).to match(/Building site/)
  end
end
