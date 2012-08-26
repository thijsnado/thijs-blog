require 'spec_helper'

describe Post do

  context 'tags' do
    it 'converts array of tags into string seperated by spaces' do
      post = FactoryGirl.build_stubbed(:post, :tags => %w(ruby rails))
      post.tag_list.should == 'ruby rails'
    end

    it 'converts string of tags into array' do
      post = FactoryGirl.build_stubbed(:post, :tags => [])
      post.tag_list = 'ruby rails'
      post.tags.should == %w(ruby rails)
    end
  end
end
