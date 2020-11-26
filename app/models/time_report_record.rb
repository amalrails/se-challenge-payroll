class TimeReportRecord < ApplicationRecord
  belongs_to :employee
  belongs_to :job_group
  belongs_to :time_report
end
