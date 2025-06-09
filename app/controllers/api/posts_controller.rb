class Api::PostsController < ApplicationController
  skip_before_action :authenticate_api_request, only: [ :create, :update, :destroy ]
  before_action :require_admin_api_key, only: [ :create, :update, :destroy ]
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
      render json: @post, status: :created
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
    if params[:post]
      params.require(:post).permit(:title, :content, tags: [])
    else
      params.permit(:title, :content, tags: [])
    end
  end

  def require_admin_api_key
    api_key = request.headers["X-API-KEY"]

    unless ActiveSupport::SecurityUtils.secure_compare(api_key.to_s, ENV["ADMIN_API_KEY"].to_s)
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
