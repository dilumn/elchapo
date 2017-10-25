require 'net/http'
require 'json'
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

      @ssl = uri.scheme == 'https'
      if ssl
        @uri = URI("https://#{@host}:#{@port}")
      else
        @uri = URI("http://#{@host}:#{@port}")
      end
    end

    def send_single(payload)
      http = ::Net::HTTP.new(@host, @port)
      if @ssl
        http.use_ssl = true
      end
      header = {'Content-Type' => 'application/json'}
      request = ::Net::HTTP::Post.new(uri, header)
      request.basic_auth(@user, @pass)
      request.body = payload
      response = http.request(request)
      return response.body
    end

  end

end