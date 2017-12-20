require 'net/http'
require 'uri' 

module DataPaga
  module Rest
    module Requests

      BASE_URL = "https://datapaga-staging.herokuapp.com/v1/".freeze

      def send(params, options, resource, url, uuid)
       
        options["#{resource}"] = params.merge(credentials)

        url = BASE_URL+url+uuid
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
    end
  end
end
