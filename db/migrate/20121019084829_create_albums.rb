class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums, :id => false do |t|
      t.string :eartist_id
      t.string :title
      t.integer :year

      #t.timestamps
    end
    add_index :albums, :eartist_id
    add_index :albums, :title
  end
end
