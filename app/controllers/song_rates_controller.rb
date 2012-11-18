class SongRatesController < ApplicationController
  def create
    @rate = SongRate.new(params[:song_rate])
    params[:user_id] = @rate.user_id
    params[:tag_id] = @rate.tag_id
    @user_rated = current_user.song_rates(@rate.tag_id)
    respond_to do |format|
      if @rate.save
        format.html { redirect_to @rate, notice: 'Rate was successfully created.' }
        format.json { render json: @rate, status: :created, location: @rate }
        format.js {}
      else
        format.html { render action: "new" }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @rate = SongRate.find(params[:id])
    params[:user_id] = @rate.user_id
    params[:tag_id] = @rate.tag_id
    @rate.destroy
    @user_rated = current_user.song_rates(@rate.tag_id)
    respond_to do |format|
      format.html { redirect_to rates_url }
      format.json { head :no_content }
      format.js { render "create" }
    end
  end

end
