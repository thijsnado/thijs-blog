require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    it 'should format markdown as html' do
      doc = <<MARKDOWN
= h1
== h2

i am a paragraph

```ruby
puts 'hello'
```
MARKDOWN
      expected = "<p>= h1<br>\n== h2</p>\n\n<p>i am a paragraph</p>\n<div class=\"highlight\"><pre><span class=\"nb\">puts</span> <span class=\"s1\">&#39;hello&#39;</span>\n</pre>\n</div>\n"
      helper.markdown_to_html(doc).should == expected
    end
  end
end
