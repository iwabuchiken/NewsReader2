# coding: utf-8

class KeywordsController < ApplicationController
  # Layout
  layout "admin"

  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.all

    # @new_kw = Keyword.new
#     
    # @new_kw.words = "米国　米　アメリカ"
    # @new_kw.save

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keywords }
    end
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/new
  # GET /keywords/new.json
  def new
    @keyword = Keyword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/1/edit
  def edit
    @keyword = Keyword.find(params[:id])
    
    @genres = Genre.find(:all, :order => "id")
  end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(params[:keyword])

    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
        format.json { render json: @keyword, status: :created, location: @keyword }
      else
        format.html { render action: "new" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keywords/1
  # PUT /keywords/1.json
  def update
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      if @keyword.update_attributes(params[:keyword])
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword = Keyword.find(params[:id])
    @keyword.destroy

    respond_to do |format|
      format.html { redirect_to keywords_url }
      format.json { head :no_content }
    end
  end#def destroy
  
  def ajax
    @categories = Category.find_all_by_genre_id(2, :order => "id")
    
    html = %Q! <div class="field">
              <label for="keyword_category_id">Category</label><br />
          
              <select id="keyword_genre_id" name="keyword[genre_id]">!
               
    @categories.each do |item|
        if item.id == 1
          html += %Q!<option value="#{item.id}" selected="selected">#{item.name}</option>!
        else
          html += %Q!<option value="#{item.id}">#{item.name}</option>!
        end
                    # %Q!<option value="1">soci</option>
          # <option value="2" selected="selected">int</option>
          # <option value="3">bus_all</option></select>
#                 
            # </div>!
    end
    
    html += %Q!</select></div>!
    
    msg = ""
    
    @categories.each do |item|
      msg += "#{item.id}:#{item.name}/"
      # msg += item.id + ":" + item.name + "/"
      # msg += item.id + "-"
      # msg += item.name + "/"
    end
    
    render text: html
    # render text: msg
    # render :partial => "form"
    # render text: Genre.find_by_id(1).name.to_s
    # render text: %Q! <div class="field">
    # <label for="keyword_subcat_id">Subcat</label><br />
    # <input id="keyword_subcat_id" name="keyword[subcat_id]" type="number" />
  # </div>!
  end#def ajax
  
end
