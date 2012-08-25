class Post
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  field :tag_list, type: String
  field :published_at, type: Time
end
