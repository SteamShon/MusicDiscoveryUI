class AddSongIdIndexToSongs < ActiveRecord::Migration
  def change
  end
  add_index :songs, :song_id
end
