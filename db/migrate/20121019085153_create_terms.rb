class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms, :id => false do |t|
      t.string :eartist_id
      t.string :tag

      #t.timestamps
    end
    add_index :terms, :eartist_id
  end
end
