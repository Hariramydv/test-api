class Api::V1::CampaignsController < ApplicationController
  before_action :set_params, only: %i[show update destroy]

  def index
    @campaigns = Campaign.all
    render json: @campaigns
  end

  def show
    render json: @campaign.to_json(include: :comments)
  end


  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      render json: @campaign ,status: :ok
    else
      render error: {error: "unable to create campaign"}, status: 400     
    end
  end

  def update
    if @campaign
      @campaign.update(campaign_params)
      render json: {message: "successfully updated"},status: :ok
    else
      render json: {error: "unable to update campaign"}, status: 400
    end
  end

  
  def destroy
    if @campaign
      @campaign.destroy
      render json: {message: "successfully destroy"},status: :ok
    else
      render json: {error: "unable to destroy campaign"}, status: 400
    end
  end

  private

  def set_params
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:title, :purpose, :estimated_duration)
  end
end
