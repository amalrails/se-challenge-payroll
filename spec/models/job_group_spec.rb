# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobGroup, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:group_name) }
    it { should validate_presence_of(:rate) }
    it { should validate_uniqueness_of(:group_name) }
    it { should validate_numericality_of(:rate) }
    it { should allow_value(20).for(:rate) }
    it { should_not allow_value('t').for(:rate) }
    it { should_not allow_value(0).for(:rate) }
  end

  describe 'Associations' do
    it { should have_many(:employees) }
    it { should have_many(:time_report_records) }
  end
end
