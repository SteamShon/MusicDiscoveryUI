class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :track_id
      t.string :title
      t.string :song_id
      t.string :release
      t.string :artist_id
      t.string :artist_mbid
      t.string :artist_name
      t.float :duration
      t.float :artist_familiarity
      t.float :artist_hotttnesss
      t.integer :year

      #t.timestamps
    end
    add_index :songs, :song_id, :unique => true
    add_index :songs, :artist_id
  end
end
