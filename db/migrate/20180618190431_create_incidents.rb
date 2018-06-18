class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.integer :location_id
      t.integer :reason_id
      t.integer :age
      t.string :sex
      t.string :ethnicity
      t.string :race
      t.datetime :date
    end
  end
end
