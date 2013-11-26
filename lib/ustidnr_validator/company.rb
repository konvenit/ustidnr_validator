module UstidnrValidator
  class Company < UstidnrValidator::Base

    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :ust_id_nr, :name, :city, :plz, :street, :print

    def to_request_params
      {:ust_id_nr => ust_id_nr, :company_name => name, :city => city, :plz => plz, :street => street, :print => ('ja' if print.present?) }
    end

    def valid?
      valdiate_empty
      validate if errors.count.zero?
      errors.count.zero?
    end

    def valdiate_empty
      errors.add :ust_id_nr, "could not be empty" if ust_id_nr.blank?
      errors.add :city, "could not be empty" if city.blank?
      errors.add :name, "could not be empty" if name.blank?
    end

    def validate
      result = UstidnrValidator::RpcClient.fetch(to_request_params)
      errors.add :ust_id_nr, error_codes(result['ErrorCode'].to_i) if result['ErrorCode'].to_i != 200
      errors.add :city,      result_codes(result['Erg_Ort'])       if result['Erg_Ort']   !=  'A'
      errors.add :name,      result_codes(result['Erg_Name'])      if result['Erg_Name']  != 'A'
    end

    def self.build(params)
      Company.new.tap do |company|
        params.each do |k,v|
          company.send "#{k}=",v
        end
      end
    end
  end
end
