class Grape::Middleware::Lograge::Railtie < Rails::Railtie
  initializer 'grape.middleware.lograge', after: :load_config_initializers do
    filter_class = Rails::VERSION::MAJOR > 5 ? ActiveSupport::ParameterFilter : ActionDispatch::Http::ParameterFilter

    Grape::Middleware::Lograge.filter = filter_class.new(Rails.application.config.filter_parameters)

    ::Lograge::RequestLogSubscriber.attach_to :grape
  end
end
