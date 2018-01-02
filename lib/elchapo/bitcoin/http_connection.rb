require 'json'
require 'rest-client'

module Bitcoin
  class HttpConnection < Client

    def initialize(host, user:, pass:)
      super()
      @user = user
      @pass = pass
      @url = host

      @header = {'Content-Type' => 'application/json'}
    end

    def send_single(payload)
      resp = RestClient::Request.execute(
        user: @user,
        password: @pass,
        method: :post,
        url: @url,
        payload: payload,
        headers: @header
      )
      return resp
    end

  end

end