module Lograge
  module Formatters
    class RailsLogger
      INTERNAL_PARAMS = %w(controller action format _method only_path)

      def call(data)
        lines = start_processing(data)
        lines << completed(data)

        lines.join("\n")
      end

      def start_processing(data)
        params  = data[:params].except(*INTERNAL_PARAMS)
        format  = data[:format]
        format  = format.to_s.upcase if format.is_a?(Symbol)

        lines = []

        lines << "Processing by #{data[:controller]}##{data[:action]} as #{format}"
        lines << "  Parameters: #{params.inspect}" unless params.empty?

        lines
      end

      def completed(data)
        status = data[:status]

        puts ActionDispatch::ExceptionWrapper.rescue_responses

        if data[:error]
          "Exception #{status} #{data[:error]} after #{data[:duration].round}ms"
        else
          "Completed #{status} #{Rack::Utils::HTTP_STATUS_CODES[status]} in #{data[:duration].round}ms"
        end
      end
    end
  end
end
