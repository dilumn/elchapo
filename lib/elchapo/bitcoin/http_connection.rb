require 'net/http'
require 'json'
require 'rest-client'

module Bitcoin
  class HttpConnection < Client
    attr_accessor :host, :port, :uri, :ssl

    def initialize(host, user:, pass:)
      super()
      uri = URI.parse(host)
      raise ArgumentError unless ['http', 'https'].include? uri.scheme
      @host = uri.host
      @port = uri.port
      @user = user
      @pass = pass
      # @http = ::Net::HTTP.new(@host, @port)

      @uurl = host

      # @ssl = uri.scheme == 'https'
      # if ssl
      #   @uri = URI("https://#{@host}:#{@port}")
      # else
      #   @uri = URI("http://#{@host}:#{@port}")
      # end

      @header = {'Content-Type' => 'application/json'}
      # @request = ::Net::HTTP::Post.new(uri, header)
    end

    def send_single(payload)
      # if @ssl
      #   @http.use_ssl = true
      # end

      resp = RestClient::Request.execute(
        user: @user,
        password: @pass,
        method: :post,
        url: @uurl,
        payload: payload,
        headers: @header
      )

      # @request.basic_auth(@user, @pass)
      # @request.body = payload
      # response = @http.request(@request)
      return resp
    end

  end

end