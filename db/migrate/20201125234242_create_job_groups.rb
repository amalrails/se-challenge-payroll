class CreateJobGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :job_groups do |t|
      t.string :group_name, limit: 10
      t.decimal :rate

      t.timestamps
    end
    add_index :job_groups, :group_name, unique: true
  end
end
