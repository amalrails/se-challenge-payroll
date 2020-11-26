class CreateTimeReports < ActiveRecord::Migration[6.0]
  def change
    create_table :time_reports do |t|
      t.string :name, limit: 20, unique: true

      t.timestamps
    end
  end
end
