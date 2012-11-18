class Artist < ActiveRecord::Base
  attr_accessible :artist_name, :eartist_id, :id
  searchable do 
    text :artist_name
  end
  def self.solver_types
    [["ALS-WR(matrix factorization) on implicit feedback", 0], 
    ["Item-based CF with customized similarity measure", 2],
    ["Label Propagation", 3]]
  end
  def terms
    Term.where("eartist_id = ?", eartist_id)
  end

  def songs(album_title=nil)
    if album_title
      Song.where("artist_id = ? and release = ?", eartist_id, album_title)
    else
      Song.where("artist_id = ?", eartist_id)
    end
  end
  def albums
    Song.where("artist_id = ?", eartist_id).select("distinct release")
  end
  def index
    begin
      IndexMap.where("eartist_id = ?", eartist_id)[0].id
    rescue
      nil
    end
  end
  def image
    url = "http://developer.echonest.com/api/v4/artist/images?"
    url += "api_key=#{api_key}&id=#{eartist_id}&license=unknown"
    images = JSON.parse(Net::HTTP.get(URI.parse(url)))["response"]["images"]
    image_link = images.size > 0 ? images[0]["url"] : nil
  end
  private
    def api_key
      "HBNMUPWLPFKAFODW8"
    end
    def customer_key
      "6bc9c596dcabdbb7301fd012022a7a08" 
    end
    def secret
      "HYsFfZNMTQuTjTzQ0TlBRw"
    end
end
