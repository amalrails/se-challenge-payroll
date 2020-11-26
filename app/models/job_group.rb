# frozen_string_literal: true

class JobGroup < ApplicationRecord
  has_many :employees
  has_many :time_report_records

  validates :group_name, presence: true, uniqueness: true
  validates :rate, presence: true
  validates :rate, numericality: { greater_than: 0 }
end
