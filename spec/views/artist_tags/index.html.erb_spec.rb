require 'spec_helper'

describe "artist_tags/index" do
  before(:each) do
    assign(:artist_tags, [
      stub_model(ArtistTag,
        :user_id => 1,
        :title => "Title"
      ),
      stub_model(ArtistTag,
        :user_id => 1,
        :title => "Title"
      )
    ])
  end

  it "renders a list of artist_tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
