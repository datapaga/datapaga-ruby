module DataPaga
  module Cards
    include DataPaga::Rest::Requests

    def list_cards(params = {})
      send(params,
           {"card" => ""},
           'card',
           'cards',
           '/list')
    end

    def card_detail(params)
      send(params,
          {"card" => ""},
          'card', 
          'cards/detail/',
          params[:uuid])
    end

    # 
  end
end