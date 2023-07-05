# encoding: utf-8

require "spec_helper"

describe UstidnrValidator::RpcClient do
  describe "fetch" do
    it "should raise an error when owner_ustid is not set" do
      expect do
        UstidnrValidator::RpcClient.fetch("")
      end.to raise_error(/owner_ustid is not set/)
    end
  end
end
