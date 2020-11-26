# frozen_string_literal: true

class TimeReport < ApplicationRecord
  has_many :time_report_records

  validates :name, presence: true, uniqueness: true
  validates :name, format: { with: /\b(time-report-)\d+\b(.csv)/ }
end
