require 'spec_helper'
require 'markdown_to_html'

describe MarkdownToHTML do
  describe "self.markdown_to_html" do
      it 'should format markdown as html' do
        doc = <<MARKDOWN
= h1
== h2

i am a paragraph

```ruby
puts 'hello'
```
MARKDOWN


        expected = "<p>= h1<br>\n== h2</p>\n\n<p>i am a paragraph</p>\n<div class=\"highlight\"><pre><span class=\"nb\">puts</span> <span class=\"s1\">&#39;hello&#39;</span>\n</pre></div>"
        MarkdownToHTML.markdown_to_html(doc).should == expected
      end

      it 'show gracefully handle programming languages that pygments does not recognize' do
        doc =<<MARKDOWN
```herpaderp
derp "hello world"
```
MARKDOWN

        MarkdownToHTML.markdown_to_html(doc).should == %Q{<div class=\"highlight\"><pre><span class=\"n\">derp</span> &quot;<span class=\"n\">hello</span> <span class=\"n\">world</span>&quot;\n</pre></div>}
      end
  end
end
