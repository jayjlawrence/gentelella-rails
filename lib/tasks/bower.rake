require 'json'
require 'nokogiri'
require 'find'

namespace :bower do
  # desc "updates JS version references in README and VERSION files"
  # task :bump do
  #   bump_readme_file
  #   bump_version_file
  # end

  desc 'updates javascripts from bower package manager'
  task :update do
    puts `bower install gentelella --save`
  end

  desc 'vendors javascripts, stylesheets, and fonts for rails assets pipeline'
  task :vendor do

    # Clear out the existing fonts, javascripts, and stylesheets
    FileUtils.rm_rf 'assets/javascripts'
    FileUtils.rm_rf 'assets/stylesheets'
    FileUtils.rm_rf 'assets/fonts'
    FileUtils.rm_rf 'assets/images'

    # Extract the asset references from the example pages
    assets_list=assets

    # Copy the javascript assets
    assets_list[:javascript].each { |path|
      cp_asset path
    }
    # Write the gentelella.js file
    write_javascript(assets_list[:javascript])

    # Copy the stylesheet assets
    assets_list[:css].each { |path|
      cp_asset path
    }
    # Write the gentelella.css.scss file
    write_css(assets_list[:css])

    # Copy all the fonts
    Find.find('bower_components/gentelella/vendors') { |path|
      next unless path.end_with?('woff') || path.end_with?('ttf')
      dest = path.sub('bower_components/gentelella/vendors/', 'assets/fonts/')
      puts 'vendoring ' + File.basename(dest)
      FileUtils.mkdir_p File.dirname(dest)
      FileUtils.cp path, dest
    }

    # Copy all the map files
    Find.find('bower_components/gentelella/vendors') { |path|
      next unless path.end_with?('js.map') || path.end_with?('css.map')
      dest = path.sub('bower_components/gentelella/vendors/', 'assets/'+(path.end_with?('js.map') ? 'javascripts/' : 'stylesheets/') )
      puts 'vendoring ' + File.basename(dest)
      FileUtils.mkdir_p File.dirname(dest)
      FileUtils.cp path, dest
    }

    # Copy the sample images
    Find.find('bower_components/gentelella/production/images') { |path|
      next unless path.end_with?('.png') || path.end_with?('.jpg')
      dest_dir = File.join('assets', 'images', 'gentelella')
      puts 'vendoring ' + File.basename(dest_dir)
      FileUtils.mkdir_p dest_dir
      FileUtils.cp path, dest_dir
    }

    # Copy the sample files to erb content templates
    content_files=[]
    Dir.glob(bower_asset_path+'/production/*.html').each { |path|
      next if files_omit.include?(File.basename(path))
      page = Nokogiri::HTML(open(path))
      div=page.css('div').select { |d| d.attr('role')=='main' }[0]
      if div
        content=div.children.to_s
        content_file=File.join('lib', 'generators', 'gentelella', 'install', 'templates', 'views', 'gentelella', File.basename(path+'.erb'))
        FileUtils.mkpath File.dirname(content_file)
        puts 'vendoring ' + File.basename(content_file)
        File.open(content_file, 'w') { |fout| fout.write content }
        content_files << File.basename(content_file)
      else
        puts "Could not find the content section for file #{path}"
      end
    }

    # Generate a controller to respond to all of the content file 'actions'
    write_gentelella_controller content_files

    # Update the versions in files
    bump_readme_file
    bump_version_file
  end
end

def version_from_bower
  data = JSON.load(File.open('bower_components/gentelella/.bower.json'))
  data['version']
end

def version_build
  build=File.read('BUILD').chomp.strip
end

def gem_path
  File.dirname(File.expand_path(File.join(__FILE__, '..', '..')))
end

def cp_asset filename
  base_filename = File.basename(filename)
  assets_folder = File.join('assets', base_filename.end_with?('.js') ? 'javascripts' : 'stylesheets', File.dirname(filename).sub('../build/',''))
  puts 'vendoring ' + base_filename
  FileUtils.mkdir_p assets_folder
  FileUtils.cp File.join(bower_asset_path, 'vendors', filename), assets_folder
end

def bump_readme_file
  readme_filename='README.md'
  readme = File.read(readme_filename)
  File.open(readme_filename, 'w') { |f|
    f.puts readme.sub(%r{(The Gentelellia Theme version in this release is )[\d\.]+}m, "\\1#{version_from_bower}").sub(%r{(Gem build is) \d+}mi, "\\1 #{version_build}")
  }
end

def bump_version_file
  version_filename = File.join('lib', 'gentelella', 'version.rb')
  version_file = File.read(version_filename)
  File.open(version_filename, 'w') { |f|
    f.puts version_file.sub(%r{(VERSION ?= ?)'[\d\.]+'}m, "\\1'#{version_from_bower}.#{version_build}'")
  }
end

# Extract all the script and css hrefs from all of the example pages
def assets

  javascript={}
  css={}

  Dir.glob(bower_asset_path+'/production/*.html').each { |path|
    next if files_omit.include?(File.basename(path))
    page = Nokogiri::HTML(open(path))
    javascript[path]=[]
    css[path]=[]
    page.css('script').each { |st|
      javascript[path] << st.attr('src').sub('../vendors/', '') if st.attr('src') && st.attr('src').start_with?('../')
    }
    page.css('link').each { |st|
      css[path] << st.attr('href').sub('../vendors/', '') if st.attr('rel') && st.attr('rel') == 'stylesheet'
    }
  }

# Merge the lists of script and css references using array union
  javascript_src=[]
  javascript.values.map { |s| javascript_src = javascript_src | s }
  javascript_src.uniq!

# Omit the references that we won't include in the gem
  javascript_omit.each { |s| javascript_src.delete(s) }

  css_src=[]
  css.values.map { |s| css_src = css_src | s }
  css_src.uniq!

  css_omit.each { |s| css_src.delete(s) }

  puts 'Assets for index.html are:'
  puts 'Javascript'
  puts ' - '+javascript[bower_asset_path+'/production/index.html'].join("\n - ")
  puts 'CSS'
  puts ' - '+css[bower_asset_path+'/production/index.html'].join("\n - ")

  {
      javascript: javascript_src,
      css: css_src,
  }

end

def bower_asset_path
  'bower_components/gentelella'
end

# Example files that will be ignored for asset extraction
def files_omit
  %w(map.html)
end

# Javascript assets that are omitted from the final package (Gentelella file reference)
def javascript_omit
  %w()
end

# CSS assets that are omitted from the final package (Gentelella file reference)
def css_omit
  %w()
end

def write_javascript asset_list
  File.open('assets/javascripts/gentelella.js', 'w') { |fout|
    fout.puts <<HEADER
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
HEADER

    asset_list.each { |asset|
      fout.puts "//= require #{asset}" unless asset=='../build/js/custom.min.js'
    }

    fout.puts '//= require js/custom.min.js' if asset_list.include?('../build/js/custom.min.js')
    fout.puts <<FOOTER
FOOTER

  }
end

def write_css asset_list
  File.open('assets/stylesheets/gentelella.css.scss', 'w') { |fout|
    fout.puts <<HEADER
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or vendor/assets/stylesheets of plugins, if any, can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any styles
 * defined in the other CSS/SCSS files in this directory. It is generally better to create a new
 * file per style scope.
 *
HEADER

    asset_list.each { |asset|
      fout.puts " *= require #{asset}" unless asset=='../build/css/custom.min.css'
    }

    fout.puts '//= require css/custom.min.css' if asset_list.include?('../build/css/custom.min.css')
    fout.puts <<FOOTER
 */
FOOTER

  }
end

def write_gentelella_controller content_list
  File.open('controllers/gentelella_controller.rb', 'w') { |fout|
    fout.puts <<HEADER
class GentelellaController < ApplicationController

HEADER

    content_list.each { |content|
      content.sub!('.html.erb', '')

      fout.puts <<ACTION
  # GET /gentelella/#{content}
  def #{content}
  end

ACTION
    }

    fout.puts <<FOOTER
  private

end
FOOTER

  }
end
