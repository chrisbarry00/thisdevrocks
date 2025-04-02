class Api::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      # Check for a 'slug' param, fallback to 'id' if missing
      @post = Post.find_by(slug: params[:slug]) || Post.find_by(id: params[:id])

      # If no post is found, return a 404 response
      render json: { error: 'Post not found' }, status: :not_found if @post.nil?
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :content ])
    end
end
