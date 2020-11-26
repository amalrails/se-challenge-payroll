# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PayRolls', type: :request do

  describe 'GET /home' do
    it 'returns http success' do
      get '/pay_rolls/home'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /import' do
    it 'returns http success' do
      post '/pay_rolls/import'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /generate_payroll_report' do
    it 'returns http success' do
      post '/pay_rolls/generate_payroll_report'
      expect(response).to have_http_status(:success)
    end
  end
end
