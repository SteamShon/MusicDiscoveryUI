require 'spec_helper'

describe "artist_tags/edit" do
  before(:each) do
    @artist_tag = assign(:artist_tag, stub_model(ArtistTag,
      :user_id => 1,
      :title => "MyString"
    ))
  end

  it "renders the edit artist_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artist_tags_path(@artist_tag), :method => "post" do
      assert_select "input#artist_tag_user_id", :name => "artist_tag[user_id]"
      assert_select "input#artist_tag_title", :name => "artist_tag[title]"
    end
  end
end
