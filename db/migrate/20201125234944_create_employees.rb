class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name, limit: 10
      t.references :job_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
