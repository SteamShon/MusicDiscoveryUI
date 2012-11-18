class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :eartist_id
      t.string :artist_name
    end
    add_index :artists, :artist_name
  end
end
