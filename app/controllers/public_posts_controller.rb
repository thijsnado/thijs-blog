require 'markdown_to_html'

class PublicPostsController < ApplicationController

  def index
    @posts = Post.where(:published_at.lte => Time.now).desc(:published_at)
  end

  def show
    @post = Post.find_by(slug: params[:slug])
  end

  def preview
    html = MarkdownToHTML.markdown_to_html(params[:text])
    post = OpenStruct.new(body_html: html)

    render text: post.body_html
  end
end
