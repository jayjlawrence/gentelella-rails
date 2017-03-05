Setting up Devise and the Gentelella views

* Add gem 'devise' to Gemfile
* bundle install
* rails generate devise:install
* edit config/environments/development.rb
    * add config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
* edit config/initializers/devise.rb
* rails generate model User
* rake db:migrate
* rails generate gentelella:install_devise
    * copies the gentelella_auth_controller.rb file that has authentication turned on
    * adds routes to your routes.rb file
* visit the page http://<ip>:<port>/gentelella_auth/index
    * you should see the login page
    