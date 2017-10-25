require "elchapo/version"
require 'active_support'
require 'active_support/core_ext'
require 'digest/sha3'

module Elchapo

  require 'elchapo/ethereum/client'
  require 'elchapo/ethereum/connection'
  require 'elchapo/ethereum/http_connection'

  require 'elchapo/bitcoin/client'
  require 'elchapo/bitcoin/http_connection'
end
