require 'html_with_pygments'

class MarkdownToHTML
  def self.markdown_to_html(markdown)
    new(markdown).to_html
  end

  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def to_html
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(markdown).html_safe
  end
end
