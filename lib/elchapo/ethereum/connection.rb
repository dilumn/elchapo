require 'socket'
module Ethereum
  class Connection < Client
    attr_accessor :ipcpath

    def initialize(ipcpath, log = true)
      super(log)
      @ipcpath = ipcpath
    end

    def send_single(payload)
      socket = UNIXSocket.new(@ipcpath)
      socket.puts(payload)
      read = socket.recvmsg(nil)[0]
      socket.close
      return read
    end
  end
end