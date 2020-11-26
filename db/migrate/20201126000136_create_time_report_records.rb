class CreateTimeReportRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :time_report_records do |t|
      t.string :report_date
      t.string :datetime
      t.decimal :hours_worked, precision: 5, scale: 2
      t.references :employee, null: false, foreign_key: true
      t.references :job_group, null: false, foreign_key: true
      t.references :time_report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
