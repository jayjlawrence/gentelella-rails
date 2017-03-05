require 'find'

# http://api.rubyonrails.org/classes/Rails/Generators/Base.html
# http://api.rubyonrails.org/classes/Rails/Generators/Actions.html
# http://www.rubydoc.info/github/wycats/thor/Thor/Actions

module Gentelella
  class InstallDeviseGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Copies sample devise templates to your application.'

    def check_for_devise_gem
      unless Gem.loaded_specs.has_key?('devise')
        gem 'devise'
        STDERR.puts <<EOM

You need to have the devise gem in your Gemfile before running this generator. 
It has been added for you. Please re-run this generator with the new Gemfile. 

Thank you ... 
   The Management

EOM
        exit 1
      end
    end

    # Copies the template files into the user's project with optional forced overwrite or alternatively with ".gentelella" as a suffix
    def copy_files

      force = options.has_key?('force')

      template_folder = File.expand_path(File.expand_path('..', __FILE__))

      Find.find(template_folder) { |path|
        next if Dir.exist?(path)
        dest = path.sub(template_folder+'/', '' )
        next unless dest.start_with?('app') || dest.start_with?('public')
        puts 'installing template ' + dest
        if File.exist?(dest) && !force
          dest += '.gentelella'
          puts " -> #{dest} because file exists already"
          FileUtils.cp path, dest
        else
          FileUtils.mkdir_p File.dirname(dest)
          FileUtils.cp path, dest
        end
      }
    end


    # Add this route to the routes.rb file to showcase the gentelella sample pages with devise authetication
    def add_route
      route <<ENDROUTE

  devise_scope :user do
    get '/gentelella_auth/:action', controller: :gentelella_auth
    get '/gentelella_auth/', to: 'gentelella_auth#index'
  end
ENDROUTE
    end

    def gen_devise_install
      generate 'devise:install'
    end

    def gen_devise_user_model
      generate 'devise', 'User'
    end

    # Generate devise controllers
    def gen_devise_controllers
      generate 'devise:controllers', 'users'

      # Inject "layout :devise" into controllers that require it
      ["app/controllers/users/sessions_controller.rb"].each do |file|
        insert_into_file file, :before => "# before_action" do
          "  layout :devise\n"
        end
      end
    end

    # Seed sample user
    def create_user_seed
      append_to_file 'db/seeds.rb' do
%q(        # Seed a sample devise user
        user = User.create! :email => 'admin@example.com', :password => 'admin123', :password_confirmation => 'admin123'
)
      end
    end

    # Notices
    def info
      puts <<EOM
=======================================================================
The sample user in the seed file is admin@example.com password admin123
=======================================================================

Your next steps are:

 rake db:create (if not done already)
 rake db:migrate
 rake db:seed

EOM
    end

  end
end
