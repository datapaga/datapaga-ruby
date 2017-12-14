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