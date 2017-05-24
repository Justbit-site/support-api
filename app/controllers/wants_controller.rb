class WantsController < ApplicationController
before_action :set_want, only: [:show, :update, :destroy]

  # GET /wants
  def index
    @wants = Want.all
    json_response(@wants)
  end

  # POST /wants
  def create
    @want = Want.create!(want_params)
    json_response(@want, :created)
  end

  # GET /wants/:id
  def show
    json_response(@want)
  end

  # PUT /wants/:id
  def update
    @want.update(want_params)
    head :no_content
  end

  # DELETE /wants/:id
  def destroy
    @want.destroy
    head :no_content
  end

  private

  def want_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_want
    @want = Want.find(params[:id])
  end
end
