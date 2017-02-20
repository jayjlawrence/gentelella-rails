# Gentelella Rails

This is gem to easily bring the Gentelella theme into a Rails project.

The Gentelellia Theme version in this release is 1.4.0 and this version's gem build is 2.

This gem:

  * packages up only the files needed for the gem to function in production
  * load everything up with just one or two requires in the Rails app that uses it
  * automates bower updates

This gem furnishes a comprehensive theme and pulls in *many* other javascript libraries such as:

  * jquery and jquery_ujs
  * bootstrap-sass and font-awesome-sass
  * icheck
  * nprogress
  * moment JS
  * bootstrap date range picker
  * fastclick
  * ChartJS
  * jquery Flot
  * DateJS
  * Switchery
  * Select2
  * Parsley JS

Since the Gentetella theme references specific javascript packages and keep things simple 
I have taken the strategy to NOT use Rails javascript gems and instead just use all of the 
assets provided by the theme when it is built.

Where a rails gem for a specific javascript library has useful helpers I will then develop a way to
incorporate that specific library into this gem.

You may also find the demo [Rails 5.x project on github](https://github.com/mwlang/gentelella-rails-demo)

## Theme Demo
![Gentelella Bootstrap Admin Template](https://github.com/mwlang/gentelella-rails-demo/blob/master/public/images/gentelella-admin-template-preview.jpg "Gentelella Theme Browser Preview")

**[Template Demo](https://colorlib.com/polygon/gentelella/index.html)**

## Installation
Add the following to your Rails application's Gemfile and bundle install:

```ruby
gem 'gentelella-rails'
```

To install the sample layout, partial and view files run the following:

```bash
bundle install
rails g gentelella:install
```

This generator will inform you which files are being added to your application. If
a file exists then the generator will put the file with a ".gentelella" extension so
that you can examine it and decide what to do next.

What I have done for you is to break up the 'index.html' file into a layout file with
a series of partials to make customization a bit more modular. You can focus on just the
left hand navigation menu. If things get messed up you can always get the generated 
file to figure out where you have gone wrong.

There are two ways to get the required JavaScript and Stylesheets in to your layout.

The first way is shown in the sample application.html.erb. Here all of the Gentelella-specific
assets are brought in by specific statements. Then your application.js/css items
are included immediately after. In this approach you do not define any of the Gentelella-specific
assets in your application.js/css files - you only put your application specific additions.
 
The second way is to use the more typical application.js/css has everything. In this case
put 'require gentelella' entries in both files first and then have your application specific
items afterwards. In this case you're building your own application layout file.

## Contributing
This gem should be automated to update by running:

```bash
rake bower:update
rake bower:vendor
```

This will extract all of the javascript and stylesheet references from the example
pages from the theme plus copy all of the fonts.


## Credits
This package was originally started by [Michael Lang](https://github.com/mwlang/gentelella-rails).

The original [theme](https://github.com/puikinsh/gentelella) was developed by
[Colorlib](https://colorlib.com/) and released under MIT license.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
