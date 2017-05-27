class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :update, :destroy]

  # GET /quotations
  def index
    @quotations = Quotation.all

    render json: @quotations
  end

  # GET /quotations/1
  def show
    render json: @quotation
  end

  # POST /quotations
  def create
    @quotation = Quotation.new(quotation_params)

    if @quotation.save
      render json: @quotation, status: :created, location: @quotation
    else
      render json: @quotation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quotations/1
  def update
    if @quotation.update(quotation_params)
      render json: @quotation
    else
      render json: @quotation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quotations/1
  def destroy
    @quotation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quotation_params
      params.require(:quotation).permit(:type, :description, :budget, :business_description, :question_id)
    end
end
