# encoding: utf-8
require 'spec_helper'

describe UstidnrValidator::Company do

  let(:company) { UstidnrValidator::Company.build :ust_id_nr => "1234", :name => "Heidelberg City Inn GmbH", :city => "Heidelberg" }
  let(:valid_reponse) { {'ErrorCode' => 200, 'Erg_Ort' => 'A', 'Erg_Name' => 'A'} }


  describe "validate" do

    it "should be valid wihout errors " do
      company.stub(:validate).and_return true
      company.should be_valid
    end

    %w{ ust_id_nr name city}.each do |attr |
      it "should not be valid without an #{attr}" do
        company.send "#{attr}=",nil
        company.stub(:validate).and_return true
        company.should_not be_valid
      end
    end

    it "should call the RpcClient " do
      UstidnrValidator::RpcClient.stub(:fetch).with({:ust_id_nr=>"1234", :company_name=>"Heidelberg City Inn GmbH", :city=>"Heidelberg",:plz=>nil, :street=>nil, :print=>nil}).and_return(valid_reponse)
      company.should be_valid
    end

    it "should call the RpcClient with print" do
      company.print = true
      UstidnrValidator::RpcClient.stub(:fetch).with(hash_including(:print=>'ja')).and_return(valid_reponse)
      company.should be_valid
    end

    it "should not be valid with ErrorCode not 200 " do
      UstidnrValidator::RpcClient.stub(:fetch).with(anything).and_return(valid_reponse.merge('ErrorCode' => 201))
      company.should_not be_valid
    end

    it "should have valid error message ErrorCode not 200 " do
      UstidnrValidator::RpcClient.stub(:fetch).with(anything).and_return(valid_reponse.merge('ErrorCode' => 201))
      company.valid?
      company.errors.full_messages.join("\n").should match(/Die angefragte USt-IdNr. ist ungültig./)
    end

    %w{ Erg_Ort Erg_Name}.each do |attr |
      it "should not be valid with #{attr} not A " do
        UstidnrValidator::RpcClient.stub(:fetch).with(anything).and_return(valid_reponse.merge(attr => 'B'))
        company.should_not be_valid
      end
    end

    %w{ Erg_Ort Erg_Name}.each do |attr |
      it "should have the vaild error on #{attr}" do
        UstidnrValidator::RpcClient.stub(:fetch).with(anything).and_return(valid_reponse.merge(attr => 'B'))
        company.valid?
        company.errors.full_messages.join("\n").should match(/stimmt nicht überein/)
      end
    end

  end
end
