module GoGamification
  class Engine < ::Rails::Engine
    isolate_namespace GoGamification
        initializer :append_migrations do |app|
      # This prevents migrations from being loaded twice from the inside of the
      # gem itself (dummy test app)
      if app.root.to_s !~ /#{root}/
        config.paths['db/migrate'].expanded.each do |migration_path|
          app.config.paths['db/migrate'] << migration_path
        end
      end
    end

    initializer 'go_gamification.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper GoGamification::ApplicationHelper
      end
    end

    initializer 'go_gamification.factories', after: 'factory_girl.set_factory_paths' do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end