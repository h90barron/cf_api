require 'spec_helper'

describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1) }
  let(:api_constraints_v2) { ApiConstraints.new(version: 2) }
  
  describe "matches?" do
    
    it "returns true when the version matches the 'Accept' header" do
      request = double(host: 'api.cf_api.dev', headers: {"Accept" => "application/vnd.cf_api.dev"})
      api_constraints_v1.matches?(request).should be_true
    end
    
    it "returns the default version when 'default' option is specified" do
      request = double(host: 'api.cf_api.dev')
      api_constraints_v2.matches?(request).should be_true
    end
  end
end