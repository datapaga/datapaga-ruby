require 'DataPaga/rest/requests'

module DataPaga
  module Charges    
    def list_charges(params = {})
      send(params, {"account_movement" => ""},
           'account_movement',
           "account_movements/transaction_history/",
           '')
    end

    def charge_detail(params)
      send(params,
           {"account_movement" => ""},
           'account_movement',
           "account_movements/history/",
           params[:id])
    end

  end
end