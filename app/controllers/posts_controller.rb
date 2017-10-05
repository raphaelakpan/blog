class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :tags]

  def index
    @posts = Post.all.order(:created_at).page(params[:page]).per(params[:size] || 5)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.tag_list = params[:tag_list]

    if @post.save
      redirect_to @post, notice: "Post successfully created"
    else
      render :show, notice: "Unable to create post"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      @post.tag_list = params[:tag_list]

      redirect_to @post, notice: "Post successfully updated!"
    else
      render :show, notice: "Unable to update post"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def tags
    render json: @post.tag_list
  end

  def all_tags
    @tags = []
    Post.all.each do |post|
      @tags.push(post.tag_list) if post.tag_list.present?
    end

    render json: @tags.flatten.uniq
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :slug, :tag_list)
  end
end
