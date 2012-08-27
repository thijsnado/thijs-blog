class PublicPostsController < ApplicationController

  def index
    @posts = Post.where(:published_at.lte => Time.now).desc(:published_at)
  end

  def show
    @post = Post.find_by(slug: params[:slug])
  end
end
