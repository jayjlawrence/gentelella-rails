require 'find'

module Gentelella
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :force, type: :string, default: false, banner: "force overwrite"

    desc 'Copies sample templates to your application.'
    def copy_files

      puts force.to_s

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

      # Add this route to the routes.rb file to showcase the gentelella sample pages
      route %q(get 'gentelella/:action', controller: 'gentelella')

    end


  end
end
