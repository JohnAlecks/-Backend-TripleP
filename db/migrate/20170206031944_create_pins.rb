class CreatePins < ActiveRecord::Migration[5.0]
  def change
    create_table :pins do |t|
      t.string :latitude
      t.string :longtitude
      t.integer :user_id
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
