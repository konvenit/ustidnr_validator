require "ustidnr_validator/version"
require "active_model"
require 'active_support/all'
   require 'logger'


require_relative 'ustidnr_validator/base'
require_relative 'ustidnr_validator/company'
require_relative 'ustidnr_validator/rpc_client'
require_relative 'ustidnr_validator/version'

module UstidnrValidator
  mattr_accessor :owner_ustid
  mattr_accessor :log_dir

  def self.logger
    build_logger
  end

  def self.build_logger

    _log_dir = UstidnrValidator.log_dir.presence || "/dev/null"
    logger  = Logger.new(_log_dir)
    logger.level = Logger::INFO
    logger
  end
end
