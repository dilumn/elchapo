require 'json'
require 'rest-client'

module Ethereum
  class HttpConnection < Client
    attr_accessor :host, :port, :uri, :ssl

    def initialize(host)
      super()

      @url = host
      @header = {'Content-Type' => 'application/json'}
    end

    def send_single(payload)
      resp = RestClient::Request.execute(
        method: :post,
        url: @url,
        payload: payload,
        headers: @header
      )
      return resp
    end

  end

end