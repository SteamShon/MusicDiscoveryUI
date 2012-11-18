class Album < ActiveRecord::Base
  attr_accessible :eartist_id, :title, :year

  def songs
    Song.where("artist_id = ? and release = ?", eartist_id, title)
  end
end
