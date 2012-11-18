class AddTagIdToRates < ActiveRecord::Migration
  def change
    add_column :rates, :tag_id, :integer
  end
end
