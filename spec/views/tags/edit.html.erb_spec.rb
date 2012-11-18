require 'spec_helper'

describe "tags/edit" do
  before(:each) do
    @tag = assign(:tag, stub_model(Tag,
      :user_id => 1,
      :title => "MyString"
    ))
  end

  it "renders the edit tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tags_path(@tag), :method => "post" do
      assert_select "input#tag_user_id", :name => "tag[user_id]"
      assert_select "input#tag_title", :name => "tag[title]"
    end
  end
end
