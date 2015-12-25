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

        lines << started_request_message(data)
        lines << "Processing by #{data[:controller]}##{data[:action]} as #{format}"
        lines << "  Parameters: #{params.inspect}" unless params.empty?

        lines
      end

      def started_request_message(data)
        'Started %s "%s" for %s at %s' % [
          data[:method],
          data[:path],
          data[:remote_ip],
          Time.now.to_default_s ]
      end

      def completed(data)
        status = data[:status]
        duration = data[:duration].round

        if data[:error]
          "Error #{status} #{data[:error]} after #{duration}ms"
        else
          lines = []
          additions = []

          additions << "ActiveRecord: %.1fms" % data[:db].to_f

          lines << "Completed #{status} #{Rack::Utils::HTTP_STATUS_CODES[status]} in #{duration}ms"
          lines << " (#{additions.join(" | ")})" unless additions.blank?

          lines.join("\n")
        end
      end
    end
  end
end
