class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false, index: true
      t.string :title, null: false
      t.string :album_type, default: "studio"

      t.timestamps
    end
  end
end
