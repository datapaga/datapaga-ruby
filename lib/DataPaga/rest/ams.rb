module DataPaga
  module Rest
    class Ams

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
    end
  end
end