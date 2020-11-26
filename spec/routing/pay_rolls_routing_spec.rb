# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PayRollController', type: :routing do
  describe 'routing' do
    it 'routes to #home' do
      expect(get: 'pay_rolls/home').to route_to('pay_rolls#home')
    end
    it 'routes to #import' do
      expect(post: 'pay_rolls/import').to route_to('pay_rolls#import')
    end
    it 'routes to #generate_payroll_report' do
      expect(post: 'pay_rolls/generate_payroll_report').to route_to('pay_rolls#generate_payroll_report')
    end
  end
end
