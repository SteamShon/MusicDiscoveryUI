class ArtistRate < ActiveRecord::Base
  attr_accessible :artist_id, :score, :tag_id, :user_id
  def artist
    begin
      Artist.find(artist_id)
    rescue
      nil
    end
  end
end
