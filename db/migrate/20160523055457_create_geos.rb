class CreateGeos < ActiveRecord::Migration
  def change
    create_table :geos do |t|
      t.string :title

      t.timestamps
    end
    add_attachment :geos, :tracker
  end
end
