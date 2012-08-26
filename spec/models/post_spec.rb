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

  describe '#published_at_parsible setter and getter' do
    it 'returns published at for getter' do
      time = Time.now
      post = FactoryGirl.build_stubbed(:post, :published_at => time)
      post.published_at_parsible.should be_within(1.second).of(time)
    end

    it 'uses smart times to set published_at' do
      # strange issue with timecop and time operators
      day = 1.day.to_i

      Timecop.freeze do
        time = Time.now
        post = FactoryGirl.build_stubbed(:post)
        post.published_at_parsible = 'now'
        post.published_at.should be_within(1.second).of(time)

        post.published_at_parsible = '1 day from now'
        post.published_at.should be_within(1.second).of(time + day)
      end
    end

    it 'handles blank strings by saving plublished at as nil' do
      post = FactoryGirl.build_stubbed(:post)
      post.published_at_parsible = ''
      post.published_at.should be_nil
    end
  end
end
