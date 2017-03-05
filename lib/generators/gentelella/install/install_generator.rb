require 'find'

# http://api.rubyonrails.org/classes/Rails/Generators/Base.html
# http://www.rubydoc.info/github/wycats/thor/Thor/Actions

module Gentelella
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Copies sample templates to your application.'

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

    # Add this route to the routes.rb file to showcase the gentelella sample pages
    def add_route
      route <<ENDROUTE
      
  get '/gentelella/:action', controller: :gentelella
  get '/gentelella/', to: 'gentelella#index'
ENDROUTE
    end

    def add_gems
      gem 'gentelella-rails'
    end

  end
end
