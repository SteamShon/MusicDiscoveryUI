class Song < ActiveRecord::Base 
  attr_accessible :id, :track_id, :title, :song_id, :release, :artist_id, :artist_mbid, :artist_name
  attr_accessible :duration, :artist_familiarity, :artist_hotttnesss, :year
  require 'youtube_it'
  @@client = YouTubeIt::Client.new

  searchable do 
    text :title, :artist_name
  end
  
  def self.solver_types
    [["ALS-WR(matrix factorization) on implicit feedback", 0], 
    ["Item-based CF with customized similarity measure", 2],
    ["Label Propagation", 3]]
  end

  def terms
    Term.where("eartist_id = ?", artist_id)
  end
  def youtube_video_id
    require 'nokogiri'
    require 'open-uri'
    begin
    url = URI.parse(URI.escape("http://gdata.youtube.com/feeds/api/videos?max-results=1&v=2&q=#{title} #{artist_name}"))
    doc = Nokogiri::XML(open(url))
    
    @youtube_video_id = nil

=begin
    doc.css('entry').each {|entry|
	current = entry.css('title').first.content.downcase
	puts "current: #{current}"
        puts "artist_name: #{artist_name}"
        puts "title: #{title}"
	if current.include?(title.downcase) and current.include?(artist_name.downcase)
	   @youtube_video_id = entry.xpath('//yt:videoid').first.content
           break
	end
    }
    @youtube_video_id
=end
 
    @youtube_video_id ||= doc.xpath('//yt:videoid').first.content
    rescue
      nil
    end
  end
  def yt_v_id
    @@client.videos_by(:query => "#{title} #{artist_name}", "max-results" => 1).videos.first.video_id.split(":")[-1]
  end
end
