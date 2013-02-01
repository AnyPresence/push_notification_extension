class Api::V1::OutagesController < ApplicationController
  respond_to :json
  
  # GET /outages
  # GET /outages.json
  def index
    @outages = ::V1::Outage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outages }
    end
  end

  # GET /outages/1
  # GET /outages/1.json
  def show
    @outage = ::V1::Outage.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @outage }
    end
  end

  # GET /outages/new
  # GET /outages/new.json
  def new
    @outage = ::V1::Outage.new

    respond_to do |format|
      format.html
      format.json { render json: @outage }
    end
  end

  # GET /outages/1/edit
  def edit
    @outage = ::V1::Outage.find(params[:id])
  end

  # POST /outages
  # POST /outages.json
  def create
    @outage = ::V1::Outage.new(params[:outage])

    respond_to do |format|
      if @outage.save
        format.json { render json: @outage, status: :created, location: @outage }
      else
        format.json { render json: @outage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /outages/1
  # PUT /outages/1.json
  def update
    @outage = ::V1::Outage.find(params[:id])

    respond_to do |format|
      if @outage.update_attributes(params[:outage])
        format.json { head :no_content }
      else
        format.json { render json: @outage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outages/1
  # DELETE /outages/1.json
  def destroy
    @outage = ::V1::Outage.find(params[:id])
    @outage.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_outages_url }
      format.json { head :no_content }
    end
  end
end
