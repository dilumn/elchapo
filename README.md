# Elchapo

Ruby API for Ethereum & Bitcoin Blockchain networks.

## Ethereum

### IPC Connection

Have a look at this blog post for a detail description about [Connect to Ethereum node using IPC](http://dilumn.github.io/ethereum/2017/10/22/connect-to-ethereum-ipc-using-ruby/)

## Installation
Once you've verified that Ruby is installed:

`gem install elchapo`


```ruby
require 'elchapo'

```

IPC Client for Ethereum

```
eth_client = Ethereum::Connection.new("/root/.ethereum/rinkeby/geth.ipc")
```

RPC Client for Ethereum

```
eth_client = Ethereum::HttpConnection.new("http://0.0.0.0:8545")
```

RPC Client for Bitcoin

```
btc_client = Bitcoin::HttpConnection.new("http://127.0.0.1:18333", user: "foo", pass: "bar")
```

After you create the connection client, you can use all these Ethereum `eth` commands & Bitcoin RPC commands.

[https://github.com/ethereum/wiki/wiki/JSON-RPC](https://github.com/ethereum/wiki/wiki/JSON-RPC)

[https://github.com/ethereum/go-ethereum/wiki/Management-APIs](https://github.com/ethereum/go-ethereum/wiki/Management-APIs)

[https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_calls_list](https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_calls_list)

`eth_client.eth_accounts`

`btc_client.getinfo`

You can pass parameters as method arguments,

`btc_client.sendtoaddress("awl2llkjalwo209ao23rjaslkjv30", 0.1)`

Make sure you are using underscore instead of capitals. Eg: `getBalance` => `get_balance`

`client.get_balance("ACCOUNT NUMBER")`

This gem is inspired from [ethereum.rb](https://github.com/EthWorks/ethereum.rb)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Elchapo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/elchapo/blob/master/CODE_OF_CONDUCT.md).
