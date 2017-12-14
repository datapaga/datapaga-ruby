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

      def list(params = {})        

        options = {"account_movement" => ""}
        options["account_movement"] = params.merge(credentials)


        url = "https://datapaga.herokuapp.com/v1/transaction_history"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = options.to_json

        response = http.request(request)

        response.body

      end

      def detail(params)
        url = "https://datapaga.herokuapp.com/v1/transaction_history/"+"#{params[:id]}"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        detail = '
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
        request.body = detail

        response = http.request(request)

        response.body
      end

      def charge(params)
        url = "https://datapaga.herokuapp.com/v1/account_movements"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        charge = '
          {
            "account_movement": {
              "api_key": "'+"#{@api_key}"+'",
              "api_secret": "'+"#{@api_secret}"+'",
              "first_name": "'+"#{params[:first_name]}"+'",
              "last_name": "'+"#{params[:last_name]}"+'",
              "web_site_url": "'+"#{params[:return_url]}"+'",
              "phone": "'+"#{params[:phone]}"+'",
              "country": "'+"#{params[:country_code]}"+'",
              "city": "'+"#{params[:city]}"+'",
              "email": "'+"#{params[:email]}"+'",
              "customer_ip": "'+"#{params[:customer_ip]}"+'",
              "region": "'+"#{params[:region]}"+'",
              "zip": "'+"#{params[:zip_code]}"+'",
              "street": "'+"#{params[:address]}"+'",
              "total_amount": "'+"#{params[:total_amount]}"+'",
              "product_description": "'+"#{params[:product_description]}"+'",
              "card_holder_name": "'+"#{params[:card_holder_name]}"+'",
              "card_number": "'+"#{params[:card_number]}"+'",
              "card_expire_month": "'+"#{params[:card_expire_month]}"+'",
              "card_expire_year": "'+"#{params[:card_expire_year]}"+'",
              "card_type": "'+"#{params[:card_type]}"+'",
              "card_security_code": "'+"#{params[:ccv]}"+'"}
            }'

        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = charge

        response = http.request(request)

        response.body
      end

      def cards(params = {})        

        options = {"card" => ""}
        options["card"] = params.merge(credentials)


        url = "https://datapaga-staging.herokuapp.com/v1/cards/list?page=1"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = options.to_json

        response = http.request(request)

        response.body

      end

      def card_detail(params = {})        

        options = {"card" => ""}
        options["card"] = params.merge(credentials)


        url = "https://datapaga-staging.herokuapp.com/v1/cards/detail/"+"#{params[:uuid]}"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = options.to_json

        response = http.request(request)

        response.body

      end

      def store_balance(params = {})     

        options = {"store" => ""}
        options["store"] = params.merge(credentials)


        url = "https://datapaga-staging.herokuapp.com/v1/stores/balance"
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host)
        request = Net::HTTP::Post.new(
          uri, 
          'Content-Type' => 'application/json'
        )
        request.body = options.to_json

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