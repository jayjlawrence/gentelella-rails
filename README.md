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

Then perform the following:

```bash
bundle install
rails g gentelella:install
```

Add the following to your assets/javascripts/application.js

```javascript
//= require gentelella
```

There is no need to include bootstrap-sprockets, font-awesome, jquery, etc. as these are all included via
the gem when you "require gentelella"

Finally, add the stylesheet directives to your assets/stylesheets/application.css.scss

```sass
*= require gentelella
```

This will pull in all necessary stylesheets including bootstrap, font-awesome, etc., which the theme uses.

```ruby
gem 'gentelella-rails'
```

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
