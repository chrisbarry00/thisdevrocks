class Api::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  # GET /api/posts
  def index
    limit = params[:limit].present? ? params[:limit].to_i : 10

    @posts = if params[:tag]
               Post.where("? = ANY (tags)", params[:tag])
    else
               Post.all
    end

    @posts = @posts.order(created_at: :desc).limit(limit)

    render json: @posts
  end

  # GET /api/posts/:slug
  def show
    render json: @post
  end

  # POST /api/posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/posts/:slug
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/posts/:slug
  def destroy
    @post.destroy!
  end

  private

  def set_post
    Rails.logger.info "PARAMS: #{params.inspect}"
    @post = Post.find_by(slug: params[:slug])

    unless @post
      Rails.logger.info "Post not found with slug: #{params[:slug]}"
      render json: { error: "Post not found" }, status: :not_found
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, tags: [])
  end
end
