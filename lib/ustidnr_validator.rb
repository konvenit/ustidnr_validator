require "ustidnr_validator/version"
require "active_model"
require "active_support/core_ext/module/attribute_accessors"
require 'logger'

module UstidnrValidator
  extend ActiveSupport::Autoload

  autoload :Base,      'ustidnr_validator/base'
  autoload :Company,   'ustidnr_validator/company'
  autoload :RpcClient, 'ustidnr_validator/rpc_client'

  mattr_accessor :owner_ustid
  mattr_accessor :log_dir
  mattr_accessor :external_logger

  def self.logger
   @@logger ||= (external_logger || build_logger)
  end

  def self.build_logger
    _log_dir     = UstidnrValidator.log_dir.presence || "/dev/null"
    logger       = Logger.new(_log_dir)
    logger.level = Logger::INFO
    logger
  end
end
