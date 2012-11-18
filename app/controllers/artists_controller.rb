class ArtistsController < ApplicationController
  def index
    respond_to do |respond|
      @user_rated = current_user.artist_rates(params[:tag_id])
      respond.html {
	@search = Artist.search do
          fulltext params[:query]
          paginate page: params[:page], per_page: 5
        end
	@search_result = @search.results
      }
      respond.js {
	@solver_type = params[:solver_type]
	@solver_name = Artist.solver_types.select{|s| s[1].to_i == @solver_type.to_i}[0]
	@port = @solver_type.to_i == 2 ? 20030 : 20020
        @artists = current_user.recs_artist(params[:tag_id], @solver_type, @port)
      }
    end 
  end

  def show_terms
    respond_to do |respond|
      @artist = Artist.find(params[:id])
      respond.js {
  	@terms = @artist.terms
      }
    end
  end
  def show_albums
    respond_to do |respond|
      @artist = Artist.find(params[:id])
      respond.js {
  	@albums = @artist.albums
      }
    end
  end
  def show_songs
    respond_to do |respond|
      @artist = Artist.find(params[:id])
      @album_index = params[:album_index]
      @albums = @artist.albums
      @album = @albums[@album_index.to_i]
      respond.js {
        @songs = @artist.songs(@album.release)
      }
    end
  end
  def play_album_songs
    respond_to do |respond| 
      respond.js {
        @artist = Artist.find(params[:id])
        @album_index = params[:album_index]
        @albums = @artist.albums
        @album = @albums[@album_index.to_i]
        @songs = @artist.songs(@album.release)
        @song_id_list = @songs.collect{|song| song.id }.join(",") 
	@video_id_list = @songs.collect{|song| song.youtube_video_id}.join(",")
      }
    end
  end
end
