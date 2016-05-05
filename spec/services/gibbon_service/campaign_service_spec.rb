require 'spec_helper'

RSpec.describe GibbonService::CampaignService, type: :job do

  SpreeMarketing::CONFIG ||= { Rails.env => {} }

  let(:list) { create(:marketing_list) }
  let(:since_send_time) { 1.day.ago.to_s }
  let(:gibbon_service) { GibbonService::CampaignService.new }
  let(:campaigns_data) { { 'campaigns' => [{ id: '12456', type: 'regular', settings: { title: 'test' },
      recipients: { list_id: list.uid }, send_time: Time.current.to_s }.with_indifferent_access] } }
  let(:contact) { create(:marketing_contact) }
  let(:recipients_data) { { 'sent_to' => [{ email_id: contact.uid, email_address: contact.email, status: 'sent' }.with_indifferent_access] } }

  describe '#retrieve_sent_campaigns' do
    before do
      allow(gibbon_service).to receive(:gibbon).and_return(gibbon_service)
      allow(gibbon_service).to receive(:campaigns).and_return(gibbon_service)
      allow(gibbon_service).to receive(:retrieve).and_return(campaigns_data)
    end

    it 'should access gibbon instance' do
      expect(gibbon_service).to receive(:gibbon).and_return(gibbon_service)
    end
    it 'should assign campaigns part path for gibbon' do
      expect(gibbon_service).to receive(:campaigns).and_return(gibbon_service)
    end
    it 'should call retrieve for campaigns from gibbon' do
      expect(gibbon_service).to receive(:retrieve).and_return(campaigns_data)
    end

    after { gibbon_service.retrieve_sent_campaigns }
  end


  describe '#retrieve_recipients' do
    before do
      allow(gibbon_service).to receive(:gibbon).and_return(gibbon_service)
      allow(gibbon_service).to receive(:reports).and_return(gibbon_service)
      allow(gibbon_service).to receive(:sent_to).and_return(gibbon_service)
      allow(gibbon_service).to receive(:retrieve).and_return(recipients_data)
    end

    it 'should access gibbon instance' do
      expect(gibbon_service).to receive(:gibbon).and_return(gibbon_service)
    end
    it 'should assign reports part path for gibbon' do
      expect(gibbon_service).to receive(:reports).and_return(gibbon_service)
    end
    it 'should assign sent-to part path for gibbon' do
      expect(gibbon_service).to receive(:sent_to).and_return(gibbon_service)
    end
    it 'should call retrieve for recipients from gibbon' do
      expect(gibbon_service).to receive(:retrieve).and_return(recipients_data)
    end

    after { gibbon_service.retrieve_recipients }
  end
end