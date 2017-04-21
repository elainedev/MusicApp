class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false, index: true
      t.string :song, null: false
      t.text :lyrics
      t.string :song_type, default: "regular"

      t.timestamps
    end
  end
end
