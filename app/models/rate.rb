class Rate < ActiveRecord::Base
  attr_accessible :eartist_id, :score, :user_id, :created_at, :updated_at, :rate_type, :tag_id
  
  def artist_rate_type
    return 0
  end
  def song_rate_type
    return 1
  end
  def artist
    begin
      Artist.where("eartist_id = ?", eartist_id)[0]
    rescue
      nil
    end
  end
  def artist_index
    begin
      IndexMap.where("eartist_id = ?", eartist_id)[0].id
    rescue
      nil
    end
  end
  def song
    begin
      Song.where("song_id = ?", eartist_id)[0]
    rescue
      nil
    end
  end
  def song_index
    begin
      SongMap.where("song_id = ?", eartist_id)[0].id
    rescue
      nil
    end
  end
end
