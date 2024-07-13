# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show destroy]


  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @comment.post, alert: 'Comment cannot be blank or longer than 501 characters.'}
      end
    end
  end


  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to @comment.post, notice: 'Comment was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
