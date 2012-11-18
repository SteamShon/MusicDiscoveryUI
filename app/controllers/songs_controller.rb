class SongsController < ApplicationController
  def index
    respond_to do |respond|
      @user_rated = current_user.song_rates(params[:tag_id])
      respond.html {
        @songs = Song.search do
          fulltext params[:query]
          paginate page: params[:page], per_page: 5
        end
        @songs = @songs.results
      }
      respond.js {
        @solver_type = params[:solver_type]
	@solver_name = Song.solver_types.select{|s| s[1].to_i == @solver_type.to_i}[0]
	@port = @solver_type.to_i == 2 ? 20040 : 20010
        @songs = current_user.recs_song(params[:tag_id], @solver_type, @port)
	#@songs = current_user.recs_song(params[:tag_id])
      }
    end
  end
  def show
    respond_to do |respond|
      respond.js {
	@index = params[:index]
	@song = Song.find(params[:id])
        @yt_video_id = @song.youtube_video_id
      }
    end
  end
  def new
    respond_to do |respond|
      respond.js {
	@songs = current_user.recs_song(params[:tag_id])
        @song_id_list = @songs.collect{|song| song.id }.join(",") 
	@video_id_list = @songs.collect{|song| song.youtube_video_id}.join(",")
      }
    end
  end
 
end
