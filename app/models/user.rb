class User < ActiveRecord::Base 
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  before_save { self.email = self.email.downcase }
  before_save :create_remember_token
  
  validate :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :tags
  has_many :artist_tags

  def artist_rates(tag_id)
    ArtistRate.where("user_id = ? and tag_id = ?", id, tag_id)
  end
  def song_rates(tag_id)
    SongRate.where("user_id = ? and tag_id = ?", id, tag_id)
  end
  def recs_artist(tag_id, solver_type=3, port=20020)
    require 'redis'
    redis = Redis.new

    rating_vector = artist_rates(tag_id).sort{|r| r.artist_id}.collect{|artist_rate|
    	"#{artist_rate.artist_id}:#{artist_rate.score}"}.join(",")
    is_cached = redis.get rating_vector
    if is_cached
      response = is_cached
    else
      url = URI.parse("http://0.0.0.0:#{port}/?user_id=#{id}&solver_type=#{solver_type}&implicit=true&ratings=#{rating_vector}&iteration=3&topK=100&sim_index=5")
      response = Net::HTTP.get(url)
      #redis.set rating_vector, response
    end
    result = []
    response.split(",").each do |t|
      id, score = t.split(":")
      begin
        result << Artist.find(id)
      rescue
        next
      end
    end
    @recs = result
  end

  def recs_song(tag_id, solver_type=3, port=20010)
    require 'redis'
    redis = Redis.new
    rating_vector = song_rates(tag_id).sort{|r| r.song_id}.collect{|song_rate| 
      "#{song_rate.song_id}:#{song_rate.score}"}.join(",")
    cache_key = "#{solver_type}\t#{rating_vector}"
    is_cached = redis.get cache_key
    if is_cached 
       response = is_cached
    else
       url = URI.parse("http://0.0.0.0:#{port}/?user_id=#{id}&solver_type=#{solver_type}&implicit=true&ratings=#{rating_vector}&iteration=3&topK=100&sim_index=6")
       response = Net::HTTP.get(url)
       redis.set cache_key, response
    end
    result = []
    response.split(",").each do |t|
      id, score = t.split(":")
      begin
        result << Song.find(id)
      rescue
        next
      end
    end
    @recs ||= result
  end
  def self.youtube_auth
    client_id = "989238565470.apps.googleusercontent.com"
    redirect_uri = "https://localhost:5000/oauth2callback"
    scope = "https://gdata.youtube.com"
    response_type = "code"
    access_type = "offline"
    req = "https://accounts.google.com/o/oauth2/auth?"
    req += "client_id=#{client_id}"
    req += "&redirect_uri=#{redirect_uri}"
    req += "&scope=#{scope}"
    req += "&response_type=#{response_type}"
    req += "&access_type=#{access_type}"
    return req
  end
  def self.yt_dev_key
    "AI39si5k_0kkWlnCjX1IzNVmlyYXH9VmqpNRJAuhC231lb5BNDJhLpBEug0MIv-jmQnUycpOLYvdOKDtIKTsG6WYSe0zhbOLow"
  end
  def self.create_playlist(title, songs)
    require 'youtube_it'
    client = YouTubeIt::Client.new(:dev_key => User.yt_dev_key, :username => "shom83", :password => 'steamshon12#$')
    playlist = client.add_playlist(:title => title, :description => "playlist description")
    
    for song in songs
      puts song.id
      begin
        client.add_video_to_playlist(playlist.playlist_id, song.youtube_video_id)
      rescue
        next
      end
    end
  end
  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
