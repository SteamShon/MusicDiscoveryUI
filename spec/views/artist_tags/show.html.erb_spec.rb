require 'spec_helper'

describe "artist_tags/show" do
  before(:each) do
    @artist_tag = assign(:artist_tag, stub_model(ArtistTag,
      :user_id => 1,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
  end
end
