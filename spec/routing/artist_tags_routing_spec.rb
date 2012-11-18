require "spec_helper"

describe ArtistTagsController do
  describe "routing" do

    it "routes to #index" do
      get("/artist_tags").should route_to("artist_tags#index")
    end

    it "routes to #new" do
      get("/artist_tags/new").should route_to("artist_tags#new")
    end

    it "routes to #show" do
      get("/artist_tags/1").should route_to("artist_tags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/artist_tags/1/edit").should route_to("artist_tags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/artist_tags").should route_to("artist_tags#create")
    end

    it "routes to #update" do
      put("/artist_tags/1").should route_to("artist_tags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/artist_tags/1").should route_to("artist_tags#destroy", :id => "1")
    end

  end
end
