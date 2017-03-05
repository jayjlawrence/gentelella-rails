module Gentelella
  class Engine < ::Rails::Engine

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w{ gentelella.css }
      Rails.application.config.assets.precompile += %w{ gentelella.js }
      %w(stylesheets javascripts fonts images).each do |sub|
        Rails.application.config.assets.paths << root.join('assets', sub).to_s
      end
    end

    initializer 'gentelella.assets.precompile' do |app|
      %w(stylesheets javascripts fonts images).each do |sub|
        app.config.assets.paths << root.join('assets', sub).to_s
      end
    end

  end
end
