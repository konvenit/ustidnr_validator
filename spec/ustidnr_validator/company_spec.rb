# encoding: utf-8

require "spec_helper"

describe UstidnrValidator::Company do
  let(:company) { UstidnrValidator::Company.build ust_id_nr: "1234", name: "Heidelberg City Inn GmbH", city: "Heidelberg" }
  let(:valid_reponse) { { "ErrorCode" => 200, "Erg_Ort" => "A", "Erg_Name" => "A" } }

  it "should looks like a rails model" do
    expect(company).not_to be_persisted
  end

  describe "validate" do
    let(:heidelberg_company) do
      {
        ust_id_nr:    "1234",
        company_name: "Heidelberg City Inn GmbH",
        city:         "Heidelberg",
        plz:          nil,
        street:       nil,
        print:        nil
      }
    end

    it "should be valid wihout errors " do
      allow(company).to receive(:validate).and_return true
      expect(company).to be_valid
    end

    %w{ ust_id_nr name city}.each do |attr |
      it "should not be valid without an #{attr}" do
        company.send "#{attr}=", nil
        allow(company).to receive(:validate).and_return true
        expect(company).not_to be_valid
      end
    end

    it "should call the RpcClient " do
      allow(UstidnrValidator::RpcClient).to receive(:fetch).with(heidelberg_company).and_return(valid_reponse)
      expect(company).to be_valid
    end

    it "should be valid for transition TLS 1.2 status " do
      transition_status = { "ErrorCode" => 222, "Erg_Ort" => "A", "Erg_Name" => "A" }

      allow(UstidnrValidator::RpcClient).to receive(:fetch).with(heidelberg_company).and_return(transition_status)
      expect(company).to be_valid
    end

    it "should call the RpcClient with print" do
      company.print = true
      allow(UstidnrValidator::RpcClient).to receive(:fetch).with(hash_including(print: "ja")).and_return(valid_reponse)
      expect(company).to be_valid
    end

    it "should not be valid with ErrorCode not 200 " do
      allow(UstidnrValidator::RpcClient).to receive(:fetch).with(anything).and_return(valid_reponse.merge("ErrorCode" => 201))
      expect(company).not_to be_valid
    end

    it "should have valid error message ErrorCode not 200 " do
      allow(UstidnrValidator::RpcClient).to receive(:fetch).with(anything).and_return(valid_reponse.merge("ErrorCode" => 201))
      company.valid?
      expect(company.errors.full_messages.join("\n")).to match(/Die angefragte USt-IdNr. ist ungültig./)
    end

    %w{ Erg_Ort Erg_Name}.each do |attr |
      it "should not be valid with #{attr} not A " do
        allow(UstidnrValidator::RpcClient).to receive(:fetch).with(anything).and_return(valid_reponse.merge(attr => "B"))
        expect(company).not_to be_valid
      end
    end

    %w{ Erg_Ort Erg_Name}.each do |attr |
      it "should have the vaild error on #{attr}" do
        allow(UstidnrValidator::RpcClient).to receive(:fetch).with(anything).and_return(valid_reponse.merge(attr => "B"))
        company.valid?
        expect(company.errors.full_messages.join("\n")).to match(/stimmt nicht überein/)
      end
    end
  end
end
