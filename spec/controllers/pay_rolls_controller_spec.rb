# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRollsController, type: :controller do
  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post #import' do
    it 'returns http success' do
      post :import
      expect(response).to have_http_status(:success)
    end
  end

  describe 'post #generate_payroll_report' do
    it 'returns http success' do
      get :generate_payroll_report
      expect(response).to have_http_status(:success)
    end
  end
end
