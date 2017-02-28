require 'find'

module Gentelella
  class InstallDeviseGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Copies sample devise templates to your application.'

    # Copies the template files into the user's project with optional forced overwrite or alternatively with ".gentelella" as a suffix
    def copy_files

      force = options.has_key?('force')

      template_folder = File.expand_path(File.expand_path('../templates', __FILE__))

      Find.find(template_folder) { |path|
        next if Dir.exist?(path)
        dest = 'app/'+path.sub(template_folder+'/', '' )
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
  authenticate :user do
    get '/gentelella_auth/:action', controller: :gentelella_auth
    get '/gentelella_auth/', to: 'gentelella_auth#index'
  end
ENDROUTE
    end

  end
end
