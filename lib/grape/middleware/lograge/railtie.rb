class Grape::Middleware::Lograge::Railtie < Rails::Railtie
  initializer 'grape.middleware.lograge', after: :load_config_initializers do
    filter_class = Rails::VERSION::MAJOR > 5 ? ActiveSupport::ParameterFilter : ActionDispatch::Http::ParameterFilter

    Grape::Middleware::Lograge.filter = filter_class.new(Rails.application.config.filter_parameters)

    if Gem::Version.new( Lograge::VERSION ) > Gem::Version.new('0.10.9')
      Lograge::LogSubscribers::Base.attach_to :grape
    else
      ::Lograge::RequestLogSubscriber.attach_to :grape
    end
  end
end
