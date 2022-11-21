class Api::V1::CommentsController < ApplicationController
  before_action :set_params, only: %i[show update destroy]
  before_action :set_campaign_id
  def index
    @comments = @campaign.comments.all
    render json: @comments
  end

  def show
    render json: @comment
  end


  def create
    @comment = @campaign.comments.new(comment_params)
    if @comment.save
      render json: @comment ,status: :ok
    else
      render error: {error: "unable to create comment"}, status: 400     
    end
  end

  def update
    if @comment
      @comment.update(comment_params)
      render json: {message: "successfully updated"},status: :ok
    else
      render json: {error: "unable to update comment"}, status: 400
    end
  end

  
  def destroy
    if @comment
      @comment.destroy
      render json: {message: "successfully destroy"},status: :ok
    else
      render json: {error: "unable to destroy Comment"}, status: 400
    end
  end

  private

  def set_params
    @comment = Comment.find(params[:id])
  end
  
  def set_campaign_id
    @campaign = Campaign.find(params[:campaign_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :campaign_id)
  end

end
