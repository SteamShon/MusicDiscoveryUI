class CreateArtistTags < ActiveRecord::Migration
  def change
    create_table :artist_tags do |t|
      t.integer :user_id
      t.string :title

      #t.timestamps
    end
    add_index :artist_tags, :user_id
  end
end
