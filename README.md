![Soy mascot Tofu](demo/content/tofu.png)

```
   oo_       .-.   wWw  wWw 
  /  _)-<  c(O_O)c (O)  (O) 
  \__ `.  ,'.---.`,( \  / ) 
     `. |/ /|_|_|\ \\ \/ /  
     _| || \_____/ | \o /   
  ,-'   |'. `---' .`_/ /    
 (_..--'   `-...-' (_.'     
```

# Soy

**A static-site generator for Rubyists**

Soy is a program to generate websites. It embraces Ruby by using ERB for making
dynamic templates instead of using another templating language.

## Why / Vision

_Ugh, another static site generator?!_ I hear you! I do! There are so many
static site generators out there, it's almost disturbing.

But I think there's space for something a little different.

Most static site generators are centered around Markdown files or HTML files,
but I think static websites have a data model and structure to them. Even a
simple blog does. And often times there are needs for more complex data models
with associations.

I want Soy to be a data model-driven site generator with support for multiple
data stores, from Markdown to `YAML::Store` to maybe things like SQLite. The
key is that the data doesn't vary per environment and is checked into the
source code since it's used to generate the site.

I also think Ruby is really joyous to code with, so by leveraging it for
templates, it's expressive and powerful. Also, when it comes to defining the
data models and helpers, it'll be easy to stand up and validate.

Of course it's not going to be as fast or as portable as Go or Rust or C but I
hope it'll be fast enough and more than friendly to work with.

I have a lot of ideas for how Soy could evolve, and I'm excited to make it
happen.

Soy is new and actively under development. You could say it's still
fermenting...

## Bugs / Features

- Write templates in ERB and use the Ruby you know and love
- Boot up a server and watch for changes

## Installation

Soy requires a modern, stable Ruby, [see ruby-lang.org](https://www.ruby-lang.org/en/downloads/)

Supported Rubies:
- 3.1
- 3.0
- 2.7

1. Install Soy with `gem install soy`
2. Create a new site with `soy new YOUR_SITE_NAME`
3. Move into it the new site's directory
4. Run `soy server` to get to building!

Your site will then be accessible at [localhost:9292](http://localhost:9292)

## Usage

`soy` or `soy help` will output the commands that are available, but the most
common ones are:

- `soy new your_site_name` – create a new site from Soy's basic template
- `soy build` – generate the HTML for your site
- `soy server` – start up a web server to handle requests & watch for site changes to trigger rebuilds

## Structure of a Soy Site

Browse `./demo/` to see a full site, but here's a breakdown of what goes into a Soy site:

- `build/` – where the HTML is output to & served from locally, don't check this in
- `content/` – where pages, images, styles, etc. live
    - e.g. `index.html.erb`
    - e.g. `about.md`
- `views/` – where page layouts live (to be evaluated)
    - `layout.html.erb` — default HTML page layout

## Content

Soy content lives in the `content/` directory. If the file name ends in `.erb`,
it'll get run through the Soy renderer for ERB.

### Markdown

Content can be authored in Markdown, which outputs HTML. Soy uses
[Kramdown](https://rubygems.org/gems/kramdown) for Markdown parsing.

### ERB

HTML and Markdown files don't need the `.erb` file extension, they'll always
get run through ERB. So that's optional and totally up to you. `.erb` can help
with syntax highlighting in your editor.

ERB content will be rendered inside the layout specified in
`views/layout.html.erb`.

ERB is neat because you can use whatever Ruby you want within it. Here's an
example with Markdown:

``` markdown
<% @title = "Neat Products Made of Soy" %>

# <%= @title %>

<% ["tofu", "tempeh", "edamame"].each do |product| %>
- <%= product %>
<% end %>
```

### Links

Link to pages and content using the relative path. Markdown example:

``` markdown
Check out [my super cool link](/cool-link).
```

That would link to the `cool-link.html` page in the build dir.

The Soy development server (and many hosts) handle extension-less HTML
requests.

You can include the extension if you want to:

``` markdown
Check out [my super cool link](/cool-link.html).
```

It's really up to you and your preferences.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Demo Site

The `./demo/` directory includes a site that can be built with Soy to test
works in progress and experiment with new features. It intends to use as many
of the features as possible with the project.

The `bin/soy` binstub can be used to run the local repo's code, so `bin/soy
build demo` will build the demo site.

[View the demo site on Netlify.](https://soy-demo.netlify.app)

## Releasing New Versions

To release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/brettchalupa/soy. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [code of
conduct](https://github.com/brettchalupa/soy/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Soy project's codebases, issue trackers, chat rooms
and mailing lists is expected to follow the [code of
conduct](https://github.com/brettchalupa/soy/blob/main/CODE_OF_CONDUCT.md).

## Friends / Enemies

- Jekyll — a really useful static site generator that uses Liquid for templating, core inspiration
- Middleman — Ruby-based site generator that I used years ago and enjoyed
- Hugo — really fast and compelling Go static site generator
