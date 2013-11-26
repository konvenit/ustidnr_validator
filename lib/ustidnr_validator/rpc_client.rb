require "xmlrpc/client"
require 'active_support/core_ext/hash'

module UstidnrValidator
  class RpcClient

    attr_reader :request_params

    def initialize(_request_params={})
      @request_params = _request_params
    end

    def server
      @server ||= XMLRPC::Client.new2('https://evatr.bff-online.de/')
    end

    def request
      raise "owner_ustid is not set " if UstidnrValidator.owner_ustid.blank?
      server.call2('evatrRPC',UstidnrValidator.owner_ustid, request_params[:ust_id_nr].to_s, request_params[:company_name].to_s, request_params[:city].to_s, request_params[:plz].to_s, request_params[:street].to_s, request_params[:print].to_s)
    end

    def convert_result(res)
      Hash.from_xml(res)["params"]['param'].map {| h| h['value']['array']['data']['value']}.inject({}) {|h,a| h[a[0]['string']] = a[1]['string'];h }
    end

    def fetch
      ok, result = request
      UstidnrValidator.logger.info result
      convert_result result
    end

    def self.fetch(_request_params)
      client = UstidnrValidator::RpcClient.new _request_params
      client.fetch
    end
  end

end
