# frozen_string_literal: true

# == Schema Information
#
# Table name: time_reports
#
#  id         :integer          not null, primary key
#  name       :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TimeReport < ApplicationRecord
  has_many :time_report_records, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :name, format: { with: /\b(time-report-)\d+\b(.csv)/ }

  class << self
    def import!(file)
      ActiveRecord::Base.transaction do
        time_report = create!(name: file.original_filename)
        CSV.foreach(file.path, headers: true) do |row|
          record = sanitize(row)
          get_job_group(record[:job_group])
          get_employee(record[:employee_id])
          create_time_report_record(record, time_report.id)
        end
      end
    end

    private

      def sanitize(row)
        { job_group: row['job group'].to_s, employee_id: row['employee id'].to_s,
          date: row['date'].to_date, hours_worked: row['hours worked'].to_f }
      end

      def get_job_group(job_group_name)
        @job_group = JobGroup.find_by_group_name(job_group_name)
      end

      def get_employee(employee_id)
        @employee = Employee.find_or_create_by!(employee_id: employee_id,
                                                job_group_id: @job_group.id)
      end

      def create_time_report_record(record, time_report_id)
        TimeReportRecord.create!(report_date: record[:date],
                                 hours_worked: record[:hours_worked].to_f,
                                 time_report_id: time_report_id,
                                 employee_id: @employee.id,
                                 job_group_id: @job_group.id)
      end
  end
end
