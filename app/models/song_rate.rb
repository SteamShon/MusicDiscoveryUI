class SongRate < ActiveRecord::Base
  attr_accessible :id, :score, :song_id, :tag_id, :user_id
  def song
    begin
      Song.find(song_id)
    rescue
      nil
    end
  end
end
