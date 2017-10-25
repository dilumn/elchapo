module Bitcoin
  class Client

    # https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_calls_list
    RPC_COMMANDS = %w(addmultisigaddress addnode backupwallet createmultisig createrawtransaction decoderawtransaction dumpprivkey dumpwallet encryptwallet getaccount getaccountaddress getaddednodeinfo getaddressesbyaccount getbalance getbestblockhash getblock getblockcount getblockhash getblocknumber getblocktemplate getconnectioncount getdifficulty getgenerate gethashespersec getinfo getmemorypool getmininginfo getnewaddress getpeerinfo getrawchangeaddress getrawmempool getrawtransaction getreceivedbyaccount getreceivedbyaddress gettransaction gettxout gettxoutsetinfo getwork help importprivkey invalidateblock keypoolrefill listaccounts listaddressgroupings listreceivedbyaccount listreceivedbyaddress listsinceblock listtransactions listunspent listlockunspent lockunspent move sendfrom sendmany sendrawtransaction sendtoaddress setaccount setgenerate settxfee signmessage signrawtransaction stop submitblock validateaddress verifymessage walletlock walletpassphrase walletpassphrasechange)

    attr_accessor :command, :id, :default_account

    def initialize
      @id = 0
    end

    def get_id
      @id += 1
      return @id
    end

    def reset_id
      @id = 0
    end

    def send_command(command,args)
      payload = {jsonrpc: "2.0", method: command, params: args, id: get_id}
      @logger.info("Sending #{payload.to_json}") if @log

      output = JSON.parse(send_single(payload.to_json))
      @logger.info("Received #{output.to_json}") if @log
      reset_id
      raise IOError, output["error"]["message"] if output["error"]
      return output["result"]
    end

    (RPC_COMMANDS).each do |rpc_command|
      method_name = rpc_command.underscore
      define_method method_name do |*args|
        send_command(rpc_command, args)
      end
    end

  end

end