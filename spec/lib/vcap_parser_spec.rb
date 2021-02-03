require 'rails_helper'

RSpec.describe VcapParser do
  describe '.load_service_environment_variables!' do
    it 'loads service level environment variables to the ENV' do
      vcap_json = '
          {
             "user-provided": [
              {
               "credentials": {
                "ENV1": "ENV1VALUE",
                "ENV2": "ENV2VALUE"
               }
              }
             ]
           }
        '
      ClimateControl.modify VCAP_SERVICES: vcap_json do
        VcapParser.load_service_environment_variables!
        expect(ENV['ENV2']).to eq('ENV2VALUE')
      end
    end
  end
end
