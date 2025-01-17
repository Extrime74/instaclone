# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  before_action :authenticate_user!, except: %i[index show]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.build
  end

  def feed
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
  
    if @post.user == current_user # Check if the post belongs to the current user
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    else
      # Handle unauthorized update attempt
      redirect_to root_path, alert: "You are not authorized to update this post."
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:image, :description, :user_id)
  end
end
