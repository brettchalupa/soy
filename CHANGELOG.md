## [Unreleased]

- Adds support for ingesting Markdown and outputting HTML
- Adds support for `.erb`-less HTML and Markdown file names while still processing with ERB
- Adds support for extension-less path serving in `soy server`
- Changes default port from Puma's default 9292 to 4848
- Adds support for `--port` flag with `soy server`, example: `soy server --port 4200` to run local server on another port

## [0.1.0] - 2022-03-03

- Initial release
- Adds `soy` command with help info
- Adds `soy build` command
- Adds `soy server` command serves HTML files and watches for changes
- Adds `soy new` command to generate a basic Soy site
