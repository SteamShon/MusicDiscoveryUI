class CreateSongRates < ActiveRecord::Migration
  def change
    create_table :song_rates do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :song_id
      t.float :score

      #t.timestamps
    end
    add_index :song_rates, [:user_id, :tag_id]
  end
end
