class CreateArtistRates < ActiveRecord::Migration
  def change
    create_table :artist_rates do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :artist_id
      t.float :score

      #t.timestamps
    end
    add_index :artist_rates, [:user_id, :tag_id]
  end
end
