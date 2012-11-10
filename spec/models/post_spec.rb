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

  describe '#save_slug' do
    it "converts all non-alphanumeric characters to - characters, upto one dash character in a row" do
      post = FactoryGirl.build_stubbed(:post, title: "the rain in spain, stays mainly$@in the plain123")
      post.send(:set_slug)
      post.slug.should == "the-rain-in-spain-stays-mainly-in-the-plain123"
    end

    it "should strip whitespec" do
      post = FactoryGirl.build_stubbed(:post, title: "    hello ")
      post.send(:set_slug)
      post.slug.should == "hello"
    end

    it "should allow you to set slug manually" do
      post = FactoryGirl.build_stubbed(:post, title: "foo bar", slug: "hardy har")
      post.send(:set_slug)
      post.slug.should == "hardy-har"
    end
  end

  context 'markdown conversion' do
    describe '#markdown_to_html' do
      it 'should format markdown as html' do
        doc = <<MARKDOWN
= h1
== h2

i am a paragraph

```ruby
puts 'hello'
```
MARKDOWN

        post = FactoryGirl.create(:post, body: doc)

        expected = "<p>= h1<br>\n== h2</p>\n\n<p>i am a paragraph</p>\n<div class=\"highlight\"><pre><span class=\"nb\">puts</span> <span class=\"s1\">&#39;hello&#39;</span>\n</pre></div>"
        post.body_html.should == expected
      end

      it 'show gracefully handle programming languages that pygments does not recognize' do
        doc =<<MARKDOWN
```herpaderp
derp "hello world"
```
MARKDOWN

        post = FactoryGirl.create(:post, body: doc)
        post.body_html.should == %Q{<div class=\"highlight\"><pre><span class=\"n\">derp</span> &quot;<span class=\"n\">hello</span> <span class=\"n\">world</span>&quot;\n</pre></div>}
      end
    end
  end
end
