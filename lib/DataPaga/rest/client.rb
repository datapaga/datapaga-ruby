require 'net/http'
require 'uri'
module DataPaga
  module Rest
    class Client

      attr_accessor :api_key, :api_secret#, :consumer_key, :consumer_secret, :proxy, :timeouts
      attr_writer :user_agent

      # Initializes a new Client object
      #
      # @param options [Hash]
      # @return [Twitter::Client]
      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?

      end

      # @return [Hash]
      def credentials
        {
          api_key: api_key,
          api_secret: api_secret
        }
      end

      # @return [Boolean]
      def credentials?
        credentials.values.none? { |v| blank?(v) }
      end

      def list(params)
        #this needs refactoring
        url = "https://datapaga.herokuapp.com/v1/transaction_history"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        list = '
          {
            "account_movement": {
              "api_key": "'+"#{@api_key}"+'",
              "api_secret": "'+"#{@api_secret}"+'",
              "start_date": "'+"#{params[:start_date]}"+'",
              "end_date": "'+"#{params[:end_date]}"+'"}
            }'

        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = list

        response = http.request(request)

        response.body

      end

      def detail(params)
        url = "https://datapaga.herokuapp.com/v1/transaction_history/"+"#{params[:id]}"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        list = '
          {
            "account_movement": {
              "api_key": "'+"#{@api_key}"+'",
              "api_secret": "'+"#{@api_secret}"+'"
            }
          }'

        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = list

        response = http.request(request)

        response.body
      end

    private

      def blank?(s)
        s.respond_to?(:empty?) ? s.empty? : !s
      end
    end
  end
end