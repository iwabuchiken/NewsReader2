class SubcatsController < ApplicationController
  # Layout
  layout "admin"

  # GET /subcats
  # GET /subcats.json
  def index
    @subcats = Subcat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subcats }
    end
  end

  # GET /subcats/1
  # GET /subcats/1.json
  def show
    @subcat = Subcat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subcat }
    end
  end

  # GET /subcats/new
  # GET /subcats/new.json
  def new
    @subcat = Subcat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subcat }
    end
  end

  # GET /subcats/1/edit
  def edit
    @subcat = Subcat.find(params[:id])
  end

  # POST /subcats
  # POST /subcats.json
  def create
    @subcat = Subcat.new(params[:subcat])

    respond_to do |format|
      if @subcat.save
        format.html { redirect_to @subcat, notice: 'Subcat was successfully created.' }
        format.json { render json: @subcat, status: :created, location: @subcat }
      else
        format.html { render action: "new" }
        format.json { render json: @subcat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subcats/1
  # PUT /subcats/1.json
  def update
    @subcat = Subcat.find(params[:id])

    respond_to do |format|
      if @subcat.update_attributes(params[:subcat])
        format.html { redirect_to @subcat, notice: 'Subcat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subcat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcats/1
  # DELETE /subcats/1.json
  def destroy
    @subcat = Subcat.find(params[:id])
    @subcat.destroy

    respond_to do |format|
      format.html { redirect_to subcats_url }
      format.json { head :no_content }
    end
  end
end
