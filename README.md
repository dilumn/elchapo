# Elchapo

Ruby API for Ethereum & Bitcoin Blockchain networks

## Ethereum

### IPC Connection

Have a look at this blog post for a detail description about [Connect to Ethereum node using IPC](http://dilumn.github.io/ethereum/2017/10/22/connect-to-ethereum-ipc-using-ruby/)

## Installation
Once you've verified that Ruby is installed:

`gem install git-plan`


```ruby
require 'elchapo'

client = Ethereum::Connection.new("/root/.ethereum/rinkeby/geth.ipc")

```

After you create the connection client, you can use all these Ethereum `eth` commands & call those methods.

[https://github.com/ethereum/wiki/wiki/JSON-RPC](https://github.com/ethereum/wiki/wiki/JSON-RPC)

[https://github.com/ethereum/go-ethereum/wiki/Management-APIs](https://github.com/ethereum/go-ethereum/wiki/Management-APIs)

`client.eth_accounts`

Make sure you are using underscore instead of capitals. Eg: `getBalance` => `get_balance`

`client.get_balance("ACCOUNT NUMBER")`

This gem is inspired & forked from [ethereum.rb](https://github.com/EthWorks/ethereum.rb)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Elchapo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/elchapo/blob/master/CODE_OF_CONDUCT.md).
