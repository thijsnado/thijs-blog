class Post
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :title, type: String
  field :body, type: String
  field :tags, type: Array
  field :published_at, type: Time

  def tag_list
    Array(tags).join(" ")
  end

  def body_summary
    String(body).slice(0..50) + "..."
  end
end
