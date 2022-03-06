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

    html_index_output = <<~HTML
      <html>
        <head>
          <title>Hello, world!</title>
        </head>
        <body>

      <h1>Hello from Soy</h1>

      <img src="/images/image.png" alt="Drawn image of a brick of tofu with eyes and a smile" />

        </body>
      </html>
    HTML

    expect(File.read("#{build_dir}/index.html")).to eql(html_index_output)

    html_about_output = <<~HTML
      <html>
        <head>
          <title>About</title>
        </head>
        <body>

      <h1 id="about-soy">About Soy</h1>

      <p>Soy is a static site generator.</p>

      <blockquote>
        <p>Deeply thought provoking quote.</p>
      </blockquote>

        </body>
      </html>
    HTML

    expect(File.read("#{build_dir}/about.html")).to eql(html_about_output)

    html_contact_output = <<~HTML
      <html>
        <head>
          <title>Contact</title>
        </head>
        <body>

      <h1 id="contact">Contact</h1>

      <p>If you’d like to contact me, please send an encrypted message over TofuMail.</p>

        </body>
      </html>
    HTML

    expect(File.read("#{build_dir}/contact.html")).to eql(html_contact_output)

    html_nested_content_output = <<~HTML
      <html>
        <head>
          <title>Nested Content</title>
        </head>
        <body>

      <h1 id="nested-content">Nested Content</h1>

      <p>It works!</p>

        </body>
      </html>
    HTML

    expect(File.read("#{build_dir}/nested/content.html")).to eql(html_nested_content_output)

    expect(Dir.glob("#{build_dir}/**/*")).to contain_exactly(
      "#{build_dir}/images",
      "#{build_dir}/images/image.png",
      "#{build_dir}/nested",
      "#{build_dir}/nested/content.html",
      "#{build_dir}/about.html",
      "#{build_dir}/contact.html",
      "#{build_dir}/index.html"
    )
  end
end
