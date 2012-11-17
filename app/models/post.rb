require 'html_with_pygments'

class Post
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :title, type: String
  field :slug, type: String
  field :body, type: String
  field :body_html, type: String
  field :tags, type: Array
  field :published_at, type: Time

  with_options presence: true do |required|
    required.validates :title
    required.validates :body
  end

  validates :slug, uniqueness: true

  before_save :set_slug
  before_save :set_body_html

  attr_accessible :title, :body, :tag_list, :published_at_parsible

  def tag_list
    Array(tags).join(" ")
  end

  def tag_list=(list)
    self.tags = list.split
  end

  def published_at_parsible
    published_at
  end

  def published_at_parsible=(time_string)
    self.published_at = Chronic.parse(time_string)
  end

  private

  def set_body_html
    self.body_html = markdown_to_html(body)
  end

  def set_slug
    sluggable = slug.present? ? slug : title
    self.slug = sluggable.to_s.strip.gsub(/[^a-zA-Z0-9]+/, '-')
  end

  def markdown_to_html(text)
    MarkdownToHTML.markdown_to_html(text)
  end
end
