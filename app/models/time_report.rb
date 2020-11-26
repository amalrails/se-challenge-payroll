# frozen_string_literal: true

class TimeReport < ApplicationRecord
  has_many :time_report_records, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :name, format: { with: /\b(time-report-)\d+\b(.csv)/ }

  def self.import!(file)
    ActiveRecord::Base.transaction do
      time_report = create!(name: file.original_filename)
      CSV.foreach(file.path, headers: true) do |row|
        time_report_record_hash = row.to_hash
        job_group = JobGroup.find_by_group_name(time_report_record_hash['job group'])
        employee = Employee.find_or_create_by!(employee_id: time_report_record_hash['employee id'],
                                               job_group_id: job_group.id)
        TimeReportRecord.create!(report_date: Time.zone.parse(time_report_record_hash['date']),
                                 hours_worked: time_report_record_hash['hours worked'].to_f,
                                 time_report_id: time_report.id, employee_id: employee.id,
                                 job_group_id: job_group.id)
      end
    end
  end
end
