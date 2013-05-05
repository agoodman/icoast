class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.float :latitude
      t.float :longitude
      t.datetime :taken_at
      t.string :full_url
      t.string :thumb_url
      t.boolean :pre
      t.string :storm
      t.string :geo_area

      t.timestamps
    end
  end
end
