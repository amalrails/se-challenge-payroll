# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PayRolls', type: :request do
  describe 'POST /import' do

    it 'returns http success' do
      expect(TimeReport).to receive(:import!).with('foo.csv')
      post '/pay_rolls/import', params: { file: 'foo.csv' }
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /fetch_payroll_report' do
    it 'returns http success' do
      get '/pay_rolls/fetch_payroll_report.json'
      expect(response.media_type).to eq "application/json"
      expect(response).to have_http_status(:success)
    end
  end
end
