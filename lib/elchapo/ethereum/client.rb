module Ethereum
  class Client

    DEFAULT_GAS_LIMIT = 4_000_000

    DEFAULT_GAS_PRICE = 22_000_000_000

    # https://github.com/ethereum/wiki/wiki/JSON-RPC
    RPC_COMMANDS = %w(web3_clientVersion web3_sha3 net_version net_peerCount net_listening eth_protocolVersion eth_syncing eth_coinbase eth_mining eth_hashrate eth_gasPrice eth_accounts eth_blockNumber eth_getBalance eth_getStorageAt eth_getTransactionCount eth_getBlockTransactionCountByHash eth_getBlockTransactionCountByNumber eth_getUncleCountByBlockHash eth_getUncleCountByBlockNumber eth_getCode eth_sign eth_sendTransaction eth_sendRawTransaction eth_call eth_estimateGas eth_getBlockByHash eth_getBlockByNumber eth_getTransactionByHash eth_getTransactionByBlockHashAndIndex eth_getTransactionByBlockNumberAndIndex eth_getTransactionReceipt eth_getUncleByBlockHashAndIndex eth_getUncleByBlockNumberAndIndex eth_getCompilers eth_compileLLL eth_compileSolidity eth_compileSerpent eth_newFilter eth_newBlockFilter eth_newPendingTransactionFilter eth_uninstallFilter eth_getFilterChanges eth_getFilterLogs eth_getLogs eth_getWork eth_submitWork eth_submitHashrate db_putString db_getString db_putHex db_getHex shh_post shh_version shh_newIdentity shh_hasIdentity shh_newGroup shh_addToGroup shh_newFilter shh_uninstallFilter shh_getFilterChanges shh_getMessages)

    # https://github.com/ethereum/go-ethereum/wiki/Management-APIs
    RPC_MANAGEMENT_COMMANDS = %w(admin_addPeer admin_datadir admin_nodeInfo admin_peers admin_setSolc admin_startRPC admin_startWS admin_stopRPC admin_stopWS debug_backtraceAt debug_blockProfile debug_cpuProfile debug_dumpBlock debug_gcStats debug_getBlockRlp debug_goTrace debug_memStats debug_seedHash debug_setHead debug_setBlockProfileRate debug_stacks debug_startCPUProfile debug_startGoTrace debug_stopCPUProfile debug_stopGoTrace debug_traceBlock debug_traceBlockByNumber debug_traceBlockByHash debug_traceBlockFromFile debug_traceTransaction debug_verbosity debug_vmodule debug_writeBlockProfile debug_writeMemProfile miner_hashrate miner_makeDAG miner_setExtra miner_setGasPrice miner_start miner_startAutoDAG miner_stop miner_stopAutoDAG personal_importRawKey personal_listAccounts personal_lockAccount personal_newAccount personal_unlockAccount personal_sendTransaction txpool_content txpool_inspect txpool_status)

    attr_accessor :command, :id, :log, :logger, :default_account, :gas_price, :gas_limit

    def initialize
      @id = 0
      @log = log
      @batch = nil
      # @formatter = Ethereum::Formatter.new
      @gas_price = DEFAULT_GAS_PRICE
      @gas_limit = DEFAULT_GAS_LIMIT
      if @log == true
        @logger = Logger.new("/tmp/ethereum_ruby_http.log")
      end
    end

    def get_id
      @id += 1
      return @id
    end

    def reset_id
      @id = 0
    end

    def int_to_hex(p)
      p.is_a?(Integer) ? "0x#{p.to_s(16)}" : p
    end

    def encode_params(params)
      params.map(&method(:int_to_hex))
    end

    def send_command(command,args)
      if ["eth_getBalance", "eth_call"].include?(command)
        args << "latest"
      end

      payload = {jsonrpc: "2.0", method: command, params: encode_params(args), id: get_id}
      @logger.info("Sending #{payload.to_json}") if @log

      output = JSON.parse(send_single(payload.to_json))
      @logger.info("Received #{output.to_json}") if @log
      reset_id
      raise IOError, output["error"]["message"] if output["error"]
      return output["result"]
    end

    (RPC_COMMANDS + RPC_MANAGEMENT_COMMANDS).each do |rpc_command|
      method_name = rpc_command.underscore
      define_method method_name do |*args|
        send_command(rpc_command, args)
      end
    end

  end

end