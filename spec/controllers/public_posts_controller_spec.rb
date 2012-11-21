require 'spec_helper'

describe PublicPostsController do
  describe "#preview" do
    it 'makes a fake post and renders it with html' do
      MarkdownToHTML.should_receive(:markdown_to_html).with('derp').and_return('<p>derp</p>')

      post 'preview', text: 'derp'

      response.body.should == '<p>derp</p>'
    end
  end
end
