class Grape::Middleware::Lograge::Railtie < Rails::Railtie
  initializer 'grape.middleware.lograge', after: :load_config_initializers do
    Grape::Middleware::Lograge.filter = ActionDispatch::Http::ParameterFilter.new Rails.application.config.filter_parameters

    Rails.application.config.lograge.custom_options = Grape::Middleware::Lograge.custom_options

    ::Lograge::RequestLogSubscriber.attach_to :grape
  end
end
