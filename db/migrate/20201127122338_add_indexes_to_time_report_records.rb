class AddIndexesToTimeReportRecords < ActiveRecord::Migration[6.0]
  def change
    add_index :time_report_records, :hours_worked
    add_index :time_report_records, :report_date
  end
end
