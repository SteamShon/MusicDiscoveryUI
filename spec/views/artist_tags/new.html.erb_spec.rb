require 'spec_helper'

describe "artist_tags/new" do
  before(:each) do
    assign(:artist_tag, stub_model(ArtistTag,
      :user_id => 1,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new artist_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artist_tags_path, :method => "post" do
      assert_select "input#artist_tag_user_id", :name => "artist_tag[user_id]"
      assert_select "input#artist_tag_title", :name => "artist_tag[title]"
    end
  end
end
