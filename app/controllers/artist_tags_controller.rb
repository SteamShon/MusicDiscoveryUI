class ArtistTagsController < ApplicationController
  # GET /artist_tags
  # GET /artist_tags.json
  def index
    @artist_tags = current_user.artist_tags

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artist_tags }
    end
  end

  # GET /artist_tags/1
  # GET /artist_tags/1.json
  def show
    @artist_tag = ArtistTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist_tag }
    end
  end

  # GET /artist_tags/new
  # GET /artist_tags/new.json
  def new
    @artist_tag = ArtistTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist_tag }
    end
  end

  # GET /artist_tags/1/edit
  def edit
    @artist_tag = ArtistTag.find(params[:id])
  end

  # POST /artist_tags
  # POST /artist_tags.json
  def create
    @artist_tag = ArtistTag.new(params[:artist_tag])

    respond_to do |format|
      if @artist_tag.save
        format.html { redirect_to artist_tags_path, notice: 'Artist tag was successfully created.' }
        format.json { render json: @artist_tag, status: :created, location: @artist_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @artist_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artist_tags/1
  # PUT /artist_tags/1.json
  def update
    @artist_tag = ArtistTag.find(params[:id])

    respond_to do |format|
      if @artist_tag.update_attributes(params[:artist_tag])
        format.html { redirect_to @artist_tag, notice: 'Artist tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artist_tags/1
  # DELETE /artist_tags/1.json
  def destroy
    @artist_tag = ArtistTag.find(params[:id])
    @artist_tag.destroy

    respond_to do |format|
      format.html { redirect_to artist_tags_url }
      format.json { head :no_content }
    end
  end
end
