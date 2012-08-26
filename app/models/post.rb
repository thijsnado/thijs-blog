class Post
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :title, type: String
  field :body, type: String
  field :tags, type: Array
  field :published_at, type: Time

  attr_accessible :title, :body, :tag_list, :parsable_published_at

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

  def body_summary
    String(body).slice(0..50) + "..."
  end
end
