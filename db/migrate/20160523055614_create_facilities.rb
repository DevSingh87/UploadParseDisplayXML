class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.references :geo, index: true, foreign_key: true
      t.string :site_name
      t.text :address
      t.string :locality_name
      t.string :state_code
      t.string :zip_code
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
