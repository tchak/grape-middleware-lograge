class Grape::Middleware::Lograge::Railtie < Rails::Railtie
  initializer 'grape.middleware.lograge', after: :load_config_initializers do
    if defined?(ActiveSupport::ParameterFilter)
      # Rails 6
      Grape::Middleware::Lograge.filter = ActiveSupport::ParameterFilter.new Rails.application.config.filter_parameters
    else
      # Rails 5
      Grape::Middleware::Lograge.filter = ActionDispatch::Http::ParameterFilter.new Rails.application.config.filter_parameters
    end

    ::Lograge::LogSubscribers::ActionController.attach_to :grape
  end
end
