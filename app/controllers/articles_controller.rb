#coding:utf-8
###coding:euc-jp
require 'basics'
require 'noko_helper'

class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json

  # @categories = []
    
  def index
    #=================================
    # @objects = try_20    # B4.1.4

    #=================================
    # @objects = try_19    # B4.1.2

    #=================================
    # @objects = try_18    # B4

    # #=================================
    @objects = try_nokogiri_17    # Categorize => "Society"
    
    #=================================
    # @objects = try_nokogiri_16    # Modify link

    # @testword = "体積"  
    #=================================
    
    
    # @try = "try_nokogiri_15"
#       
    # @objects = try_nokogiri_15    # Modify link

    #=================================
    
    # @articles = Article.all

    # @try = "try_nokogiri_14"
#       
    # @objects = try_nokogiri_14    # Modify link

    # Choose categories
    
    # genre = params['genre']
#     
    # # Switch
    # if genre == "soci"
        # @categories = ["Nuc plants", "Others"]
    # elsif genre == "int"
        # @categories = ["USA", "China", "Europe", "Others"]
    # elsif genre == "bus_all"
        # @categories = ["USA", "China", "Europe", "Others"]
    # else
      # render "Unknown category: " + genre
#       
    # end#if genre == "soci"
    
    #=================================

    # @try = "try_nokogiri_13"
#       
    # @html = try_nokogiri_13    # Modify link


    # @try = "try_nokogiri_12"
#       
    # @html = try_nokogiri_12    # Modify link

#    @try = "try_nokogiri_11"
      
    #@html = try_nokogiri_11    # Modify link


#    @try = "try_nokogiri_10"
      
 #   @html = try_nokogiri_10    # Use thread => 5 pages

    # @try = "try_nokogiri_9"
#       
    # @html = try_nokogiri_9    # Use thread => 5 pages


    # @try = "try_nokogiri_8"
#       
    # @html = try_nokogiri_8    # Use thread => 2 pages

    # @try = "try_nokogiri_7"
#       
    # @html = try_nokogiri_7    # "href" values


    # @try = "try_nokogiri_6"
#       
    # @html = try_nokogiri_6    # "href" values

    # @try = "try_nokogiri_5"
#       
    # @html = try_nokogiri_5    # "href" values
  
    # @try = "try_nokogiri_4"
#       
    # @html = try_nokogiri_4    # Multiple pages
#     
    # @html = try_nokogiri_3    # Get "a" tags
    
    # @html = try_nokogiri_2  # Open html
    
    # @xml = try_nokogiri_1  
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private 
  #================================
  # ============ try 11 ========================
  def get_docs(number)
        # Get params
    genre = params['genre']
    
    # Urls
    if genre != nil
      # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p="
      url = "http://headlines.yahoo.co.jp/hl?c=#{genre}&t=l&p="
    else
      url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p="
    end
    
    # HTML docs
    docs = []
    
    # Thread array
    threads = []
    
    # Get docs
    # 2.times do |i|
    number.times do |i|
      # Get docs
      threads << Thread.start(i, url) do
        # puts "Thred #{i.to_s}: " + urls[i] 
        # docs[i] = Nokogiri::HTML(open(urls[i]))
        docs[i] = Nokogiri::HTML(open(url + (i + 1).to_s))
      end
    
      # Join
      threads.each do |t|
        t.join
      end
    end
    
    # Return
    return docs

  end#def get_docs(number)

  # ============ try 14 ========================
  def get_atags(docs)
#    # Get doc
#    docs = get_docs(5)
#    
#    #meta_tags
#    meta_tags = nil
#    
#    # New docs
#    docs_new = []

    # href a tags
    a_tags_href = []
    
    # Modify
    docs.each do |doc|
      #--------------------
      # Modify 'a' tags
      #--------------------
      
      # Get 'a' tags
      a_tags = doc.css("div ul li a")
      
      # href value
      a_tags.each do |a_tag|
        if a_tag['href'].start_with?("/hl?")
          # Modify url
          a_tag['href'] = "http://headlines.yahoo.co.jp" + a_tag['href']
          
          # Add
          a_tags_href.push(a_tag)
          
        end#if a_tag['href'].start_with?("/hl?")
      end#a_tags.each do |a_tag|
      
#      # New doc
#      docs_new.push(a_tags_href)
      
      #--------------------
      # Modify 'charset' value
      #--------------------
      
    end#docs.each do |doc|

    # Return
    return a_tags_href
    
  end#def get_atags

  def categorize_atags(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    
    return categorize_overseas(a_tags)
    
        # # 1.
    # cat_usa = []; cat_china = [];
    # cat_europe = []; cat_others = [];
#     
    # # 
    # a_tags_categorized = []
#     
    # #
    # kw_usa = ["アメリカ", "米国", "米"] 
    # # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
#     
    # kw_china = ["中国"]
#     
    # kw_europe = ["ヨーロッパ", "欧州", "フランス", "ドイツ", "イギリス", "欧", "EU", "ギリシャ"]
#     
    # #
    # a_tags.each do |a_tag|
      # # Flag
      # is_in = false
#       
      # #
      # kw_usa.each do |word|
        # #
        # if a_tag.content.include?(word)
          # cat_usa.push(a_tag)
#           
          # #
          # is_in = true
          # break
#           
        # end#if a_tag.content.include?(word)
#           
      # end#kw_usa.each do |word|
        # # else
# 
      # #
      # kw_china.each do |word|
        # #
        # if a_tag.content.include?(word)
          # cat_china.push(a_tag)
#           
          # #
          # is_in = true
          # break
#           
        # end#if a_tag.content.include?(word)
#           
      # end#kw_usa.each do |word|
# 
      # #
      # kw_europe.each do |word|
        # #
        # if a_tag.content.include?(word)
          # cat_europe.push(a_tag)
#           
          # #
          # is_in = true
          # break
#           
        # end#if a_tag.content.include?(word)
#           
      # end#kw_europe.each do |word|
# 
      # #
      # if is_in == false
        # cat_others.push(a_tag)
      # end#if is_in == false
#           
        # # end#if a_tag.content.include?(word)
      # # end#kw_usa.each do |word|
    # end#a_tags.each do |a_tag|
#       
    # # Return
    # return [cat_usa, cat_china, cat_europe, cat_others]
    
  end#def categorize_atags(a_tags)
  
  def try_nokogiri_14
    # Get doc
    docs = get_docs(5)

    a_tags = get_atags(docs)
    
    # Categorize
    a_tags_categorized = categorize_atags(a_tags)
    
    # Return
    # return a_tags
    return a_tags_categorized
    
    #debug
#    return meta_tags
    
#    
    # return docs
    # return docs_new
    
  end#def try_nokogiri_14

  # ============ try 15 ========================
  def categorize_overseas(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # 1.
    cat_usa = []; cat_china = [];
    cat_europe = []; cat_others = [];
    
    # 
    a_tags_categorized = []
    
    #
    kw_usa = ["アメリカ", "米国", "米"] 
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china = ["中国"]
    
    kw_europe = ["ヨーロッパ", "欧州", "フランス", "ドイツ", "イギリス", "欧", "EU", "ギリシャ"]
    
    #
    a_tags.each do |a_tag|
      # Flag
      is_in = false
      
      #
      kw_usa.each do |word|
        #
        if a_tag.content.include?(word)
          cat_usa.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #
      kw_china.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|

      #
      kw_europe.each do |word|
        #
        if a_tag.content.include?(word)
          cat_europe.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
          
        # end#if a_tag.content.include?(word)
      # end#kw_usa.each do |word|
    end#a_tags.each do |a_tag|
      
    # Return
    return [cat_usa, cat_china, cat_europe, cat_others]    
  end#def categorize_overseas(a_tags)
  
  def try_nokogiri_15
    ###########################
    # Steps
    # 1. Get categories
    # 2. Get docs
    # 3. Get a_tags    
    ###########################
    
    #=====================
    # 1. Get categories
    #=====================
    # Param
    @genre = params['genre']

    # Switch
    if @genre == "soci"
      @categories = ["USA", "China", "Europe", "Others"]
        # @categories = ["Nuc plants", "Others"]
    elsif @genre == "int"
        @categories = ["USA", "China", "Europe", "Others"]
    elsif @genre == "bus_all"
        @categories = ["USA", "China", "Europe", "Others"]
    else
      @categories = ["USA", "China", "Europe", "Others"]
      # render "Unknown category: " + @genre
    end#if @genre == "soci"
    
    #=====================
    # 2. Get docs
    #=====================
    # Get doc
    docs = get_docs(5)

    #=====================
    # 3. Get a_tags
    #=====================
    a_tags = get_atags(docs)
    
    
    # Categorize
    # a_tags_categorized = categorize_atags(a_tags)
    a_tags_categorized = categorize_atags(a_tags)
    
    # Return
    # return a_tags
    return a_tags_categorized
    
    #debug
#    return meta_tags
    
#    
    # return docs
    # return docs_new
    
  end#def try_nokogiri_15

  # ============ try 16 ========================
  def categorize_try16_others(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # 1.
    cat_usa = []; cat_china = [];
    cat_europe = []; cat_others = [];
    
    # 
    a_tags_categorized = []
    
    #
    #kw_usa = ["アメリカ", "米国", "米"] 
    kw_usa = ["アメリカ", "米国", "米"]
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china = ["中国"]
    
    kw_europe = ["ヨーロッパ", "欧州", "フランス", "ドイツ", "イギリス", "欧", "EU", "ギリシャ"]
    
    #
    a_tags.each do |a_tag|
      # Flag
      is_in = false
      
      #
      kw_usa.each do |word|
        #
        if a_tag.content.include?(word)
          cat_usa.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #
      kw_china.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|

      #
      kw_europe.each do |word|
        #
        if a_tag.content.include?(word)
          cat_europe.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
          
        # end#if a_tag.content.include?(word)
      # end#kw_usa.each do |word|
    end#a_tags.each do |a_tag|
      
    # Return
    return [cat_usa, cat_china, cat_europe, cat_others]    
  end#def categorize_try16_others(a_tags)
  
  def categorize_try16_overseas(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # 1.
    cat_usa = []; cat_china = [];
    cat_europe = []; cat_korea = [];
    cat_me = []; cat_india = []
    cat_others = [];
    
    # 
    a_tags_categorized = []
    
    #
    kw_usa = ["アメリカ", "米国", "米"] 
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china = ["中国"]
    
    kw_europe = [
            # Countries
            "フランス", "ドイツ", "イギリス", "ギリシャ", "ロシア", "イタリア",
            "独", "仏", "英", "伊", "露",
            # Cities
            "ベルリン", "パリ", "ロンドン", "モスクワ",
            # Europe
            "欧", "欧州", "ヨーロッパ", "EU", "ユーロ" 
            ]
    
    kw_korea = [
            # Countries, Regions
            "韓国", "韓", "朝鮮",
            # Cities
            "ソウル", "ピョンヤン", "平城"
            ]
    
    kw_me = ["中東", 
              # Countries
              "シリア", "ヨルダン", "イラク", "イラン", "エジプト",
              "イスラエル",
              # Groups
              "ハマス"
              ]
    
    kw_india = ["インド"]
    
    #
    a_tags.each do |a_tag|
      #=============================
      # 1. USA
      # 2. China
      # 3. Europe
      # 4. Korea
      # 5. Middle East
      # 6. India
      # 0. Others
      #=============================
      # Flag
      is_in = false
      
      #
      kw_usa.each do |word|
        #
        if a_tag.content.include?(word)
          cat_usa.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #===================
      # 2. China
      #===================
      kw_china.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|

      #===================
      # 3. Europe
      #===================
      kw_europe.each do |word|
        #
        if a_tag.content.include?(word)
          cat_europe.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 4. Korea
      #===================
      kw_korea.each do |word|
        #
        if a_tag.content.include?(word)
          cat_korea.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 5. Middle East
      #===================
      kw_me.each do |word|
        #
        if a_tag.content.include?(word)
          cat_me.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 6. India
      #===================
      kw_india.each do |word|
        #
        if a_tag.content.include?(word) \
            and not a_tag.content.include?("インドネシア")
          cat_india.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 
      #===================
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
          
        # end#if a_tag.content.include?(word)
      # end#kw_usa.each do |word|
    end#a_tags.each do |a_tag|
      
    # Return
    return [cat_usa, cat_china, cat_europe, 
              cat_korea, cat_me, cat_india,
              cat_others]    
  end#def categorize_overseas(a_tags)

  def categorize_try16(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # Param
    @genre = params['genre']

    # Switching
    if @genre == "int"
      a_tags_categorized = categorize_try16_overseas(a_tags)
    else
      a_tags_categorized = categorize_try16_others(a_tags)
    end
    
    # Return
    return a_tags_categorized
    
  end#def categorize_try16(a_tags)

  def try_nokogiri_16
    ###########################
    # Steps
    # 1. Get categories
    # 2. Get docs
    # 3. Get a_tags    
    ###########################
    
    #=====================
    # 1. Get categories
    #=====================
    # Param
    @genre = params['genre']

    # Switch
    if @genre == "soci"
      @categories = ["USA", "China", "Europe", "Others"]
        # @categories = ["Nuc plants", "Others"]
    elsif @genre == "int"
        # @categories = ["USA", "China", "Europe", "Others"]
        @categories = \
              ["USA", "China", "Europe", "Korea",
                    "Middle East", "India", "Others"]
    elsif @genre == "bus_all"
        @categories = ["USA", "China", "Europe", "Others"]
    else
      @categories = ["USA", "China", "Europe", "Others"]
      # render "Unknown category: " + @genre
    end#if @genre == "soci"
    
    #=====================
    # 2. Get docs
    #=====================
    # Get doc
    docs = get_docs(5)

    #=====================
    # 3. Get a_tags
    #=====================
    a_tags = get_atags(docs)
    
    
    # Categorize
    # a_tags_categorized = categorize_atags(a_tags)
    # a_tags_categorized = categorize_overseas_try16(a_tags)
    a_tags_categorized = categorize_try16(a_tags)
    
    # Return
    # return a_tags
    return a_tags_categorized
    
    #debug
#    return meta_tags
    
#    
    # return docs
    # return docs_new
    
  end#def try_nokogiri_16

  # ============ try 17 ========================
  def categorize_try17_others(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # 1.
    cat_usa = []; cat_china = [];
    cat_europe = []; cat_others = [];
    
    # 
    a_tags_categorized = []
    
    #
    #kw_usa = ["アメリカ", "米国", "米"] 
    kw_usa = ["アメリカ", "米国", "米"]
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china = ["中国"]
    
    kw_europe = ["ヨーロッパ", "欧州", "フランス", "ドイツ", "イギリス", "欧", "EU", "ギリシャ"]
    
    #
    a_tags.each do |a_tag|
      # Flag
      is_in = false
      
      #
      kw_usa.each do |word|
        #
        if a_tag.content.include?(word)
          cat_usa.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #
      kw_china.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|

      #
      kw_europe.each do |word|
        #
        if a_tag.content.include?(word)
          cat_europe.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
          
        # end#if a_tag.content.include?(word)
      # end#kw_usa.each do |word|
    end#a_tags.each do |a_tag|
      
    # Return
    return [cat_usa, cat_china, cat_europe, cat_others]    
  end#def categorize_try17_others(a_tags)

  def categorize_try17_bus(a_tags)
    #######################
    # Steps
    # 1. Categories
    # 2. Key words
    # 3. Array of arrays
    # 4. a_tags_categorized
    # 5. Categorize
    # 6. Return
    #######################
    
    #######################
    # 1. Categories
    #######################
    cat_usa = []; cat_china_taiwan = []; cat_europe = []
    cat_tax = []; cat_nuc_plants = []; cat_enterprises = [];
    cat_economy = []; cat_others = []
    
    # #
    # cats = [cat_usa, cat_china_taiwan, cat_europe,
            # cat_tax, cat_nuc_plants, cat_enterprises,
            # cat_economy, cat_others]
    
    #######################
    # 2. Key words
    #######################
    #
    kw_usa = [
            # Country
            "アメリカ", "米国", "米",
            
            # Cities
            "ニューヨーク",
            
            ] 
    #kw_nuc_plants = ["原発", "原子力", "原子力発電所"]
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china_taiwan = ["中国", "台湾"]
    
    kw_europe = [
            # Countries
            "フランス", "ドイツ", "イギリス", "ギリシャ", "ロシア", "イタリア",
            "スペイン", "ポルトガル", "キプロス",
            "独", "仏", "英", "伊", "露",
            
            # Cities
            "ベルリン", "パリ", "ロンドン", "モスクワ",
            
            # Regions
            "欧", "欧州", "ヨーロッパ", "EU", "ユーロ", "西欧", "東欧", "北欧" 
            ]
    
    kw_tax = ["税", "税金", "消費税", "脱税"]
    
    kw_nuc_plants = ["原発", "原子力", "原子力発電所", "東電", "東京電力", "関電"]
    
    kw_enterprises = [
                  "企業", "会社",
                  
                  # Companies
                  "ソニー", "パナ", "パナソニック", "シャープ", "日興證券", 
                  "日興", "東レ",
                  
                  # Others
                  "社内", "社外",
                  ]
    
    kw_economy = [
                # Macro
                "経済", "景気", "所得", "国民",
                
                # Industries
                "エネルギー", "石油", "再生",
                ]
    
    
    #######################
    # 3. Array of arrays
    #######################
    # Key words
    kws = [kw_usa, kw_china_taiwan, kw_europe,
            kw_tax, kw_nuc_plants, kw_enterprises, kw_economy]
            
    # Categories
        #
    cats = [cat_usa, cat_china_taiwan, cat_europe,
            cat_tax, cat_nuc_plants, cat_enterprises,
            cat_economy, cat_others]

    #######################
    # 4. a_tags_categorized
    #######################
    a_tags_categorized = []
    

    #######################
    # 5. Categorize
    #######################
    #
    a_tags.each do |a_tag|
      # Flag
      is_in = false

      #
      kws.length.times do |i|
        #
        kws[i].each do |word|
          #
          if a_tag.content.include?(word)
            cats[i].push(a_tag)
            
            #
            is_in = true
            
            break
          
          end#if a_tag.content.include?(word)
          
        end#kws[i].each do |word|
        
      end#kws.length.times do |i|

      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
      
    end#a_tags.each do |a_tag|
    
    #######################
    # 6. Return
    #######################
    return cats
    
    # return [cat_nuc_plants, cat_china_taiwan, 
              # cat_tax, cat_osaka, cat_enterprises, 
              # cat_incidents,cat_others]

  end#def categorize_try17_bus(a_tags)

  def categorize_try17_society(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # 1.
    cat_nuc_plants = []; cat_china_taiwan = [];
    cat_tax = []; cat_osaka = []; cat_enterprises = [];
    cat_incidents = []; cat_others = []
    
    # 
    a_tags_categorized = []
    
    #
    #kw_usa = ["アメリカ", "米国", "米"] 
    kw_nuc_plants = ["原発", "原子力", "原子力発電所"]
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china_taiwan = ["中国", "台湾"]
    
    kw_tax = ["税", "税金", "消費税", "脱税"]
    
    kw_osaka = ["大阪", "橋下", "阪神", "関西"]
    
    kw_enterprises = ["企業", "会社", "ソニー", "パナ", 
                      "パナソニック", "シャープ", "社内", "社外",
                      "日興證券", "日興"]
    
    kw_incidents = ["逮捕", "事件", "犯罪", "犯", "罪", 
                     "虐待", "暴行", "傷害", "遺棄"]
    
    #
    a_tags.each do |a_tag|
      # Flag
      is_in = false
      
      #
      kw_nuc_plants.each do |word|
        #
        if a_tag.content.include?(word)
          cat_nuc_plants.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_nuc_plants.each do |word|

      #
      kw_china_taiwan.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china_taiwan.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_china_taiwan.each do |word|

      #
      kw_tax.each do |word|
        #
        if a_tag.content.include?(word)
          cat_tax.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_tax.each do |word|

      #
      kw_osaka.each do |word|
        #
        if a_tag.content.include?(word)
          cat_osaka.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_osaka.each do |word|

      #
      kw_enterprises.each do |word|
        #
        if a_tag.content.include?(word)
          cat_enterprises.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_enterprises.each do |word|

      #
      kw_incidents.each do |word|
        #
        if a_tag.content.include?(word)
          cat_incidents.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_incidents.each do |word|

      #
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
          
        # end#if a_tag.content.include?(word)
      # end#kw_usa.each do |word|
    end#a_tags.each do |a_tag|
    
    # Return
    return [cat_nuc_plants, cat_china_taiwan, 
              cat_tax, cat_osaka, cat_enterprises, 
              cat_incidents,cat_others]

  end#def categorize_try17_others(a_tags)
  
  def categorize_try17_overseas(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # 1.
    cat_usa = []; cat_china = [];
    cat_europe = []; cat_korea = [];
    cat_me = []; cat_india = []
    cat_others = [];
    
    # 
    a_tags_categorized = []
    
    #
    kw_usa = ["アメリカ", "米国", "米"] 
    # kw_usa = [u"アメリカ", u"米国", u"米"]gs.each do |a_tag|
    
    kw_china = ["中国"]
    
    kw_europe = [
            # Countries
            "フランス", "ドイツ", "イギリス", "ギリシャ", "ロシア", "イタリア",
            "独", "仏", "英", "伊", "露",
            # Cities
            "ベルリン", "パリ", "ロンドン", "モスクワ",
            # Europe
            "欧", "欧州", "ヨーロッパ", "EU", "ユーロ" 
            ]
    
    kw_korea = [
            # Countries, Regions
            "韓国", "韓", "朝鮮",
            # Cities
            "ソウル", "ピョンヤン", "平城"
            ]
    
    kw_me = ["中東", 
              # Countries
              "シリア", "ヨルダン", "イラク", "イラン", "エジプト",
              "イスラエル",
              # Groups
              "ハマス"
              ]
    
    kw_india = ["インド"]
    
    #
    a_tags.each do |a_tag|
      #=============================
      # 1. USA
      # 2. China
      # 3. Europe
      # 4. Korea
      # 5. Middle East
      # 6. India
      # 0. Others
      #=============================
      # Flag
      is_in = false
      
      #
      kw_usa.each do |word|
        #
        if a_tag.content.include?(word)
          cat_usa.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #===================
      # 2. China
      #===================
      kw_china.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|

      #===================
      # 3. Europe
      #===================
      kw_europe.each do |word|
        #
        if a_tag.content.include?(word)
          cat_europe.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 4. Korea
      #===================
      kw_korea.each do |word|
        #
        if a_tag.content.include?(word)
          cat_korea.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 5. Middle East
      #===================
      kw_me.each do |word|
        #
        if a_tag.content.include?(word)
          cat_me.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 6. India
      #===================
      kw_india.each do |word|
        #
        if a_tag.content.include?(word) \
            and not a_tag.content.include?("インドネシア")
          cat_india.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_europe.each do |word|

      #===================
      # 
      #===================
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false
          
        # end#if a_tag.content.include?(word)
      # end#kw_usa.each do |word|
    end#a_tags.each do |a_tag|
      
    # Return
    return [cat_usa, cat_china, cat_europe, 
              cat_korea, cat_me, cat_india,
              cat_others]    
  end#def categorize_overseas(a_tags)

  def categorize_try17(a_tags)
    #######################
    # Steps
    # 1. 
    
    
    #######################
    # Param
    @genre = params['genre']

    # Switching
    if @genre == "int"
      a_tags_categorized = categorize_try17_overseas(a_tags)
    elsif @genre == "soci"
      a_tags_categorized = categorize_try17_society(a_tags)
    elsif @genre == "bus_all"
      a_tags_categorized = categorize_try17_bus(a_tags)
    else
      a_tags_categorized = categorize_try17_others(a_tags)
    end
    
    # Return
    return a_tags_categorized
    
  end#def categorize_try17(a_tags)

  def try_nokogiri_17
    ###########################
    # Steps
    # 1. Get categories
    # 2. Get docs
    # 3. Get a_tags    
    ###########################
    
    #=====================
    # 1. Get categories
    #=====================
    # Param
    @genre = params['genre']

    # Switch
    if @genre == "soci"
      @categories = ["Nuc Plants", "China, Taiwan", 
                      "Taxes", "Osaka", "Enterprises", "Incidents", "Others"]
      #@categories = ["原発", "中国・台湾", "税金", "大阪"]

    elsif @genre == "int"
        # @categories = ["USA", "China", "Europe", "Others"]
        # @categories = \
              # ["USA", "China", "Europe", "Korea",
                    # "Middle East", "India", "Others"]
                    
        @categories = []
        
        @cats = Category.find_all_by_genre_id(2)
        
        @cats.each do |cat|
          @categories.push(cat.name)
        end
        
    elsif @genre == "bus_all"
        @categories = ["USA", "China", "Europe", "Tax",
                        "Nuc plants", "Enterprises", "Economy", "Others"]
# kws = [kw_usa, kw_china_taiwan, kw_europe,
            # kw_tax, kw_nuc_plants, kw_enterprises, kw_economy]
    # elsif @genre == "soci"
      # @categories = ["原発", "中国・台湾", "税金", "大阪"]gories = ["USA", "China", "Europe", "Others"]
      # render "Unknown category: " + @genre
    else
      @categories = ["USA", "China", "Europe", "Others"]
    end#if @genre == "soci"
    
    #=====================
    # 2. Get docs
    #=====================
    # Get doc
    docs = get_docs(5)

    #=====================
    # 3. Get a_tags
    #=====================
    a_tags = get_atags(docs)
    
    
    # Categorize
    # a_tags_categorized = categorize_atags(a_tags)
    # a_tags_categorized = categorize_overseas_try17(a_tags)
    a_tags_categorized = categorize_try17(a_tags)
    
    # Return
    # return a_tags
    return a_tags_categorized
    
    #debug
#    return meta_tags
    
#    
    # return docs
    # return docs_new
    
  end#def try_nokogiri_17

  # ============ try 18 ========================
  def try18_categorize_overseas(a_tags)
    #------------------------------
    # Steps
    # 1. Categories
    # 2. Subcategories
    # 3. Keywords
    # 4. Categorize => by categories
    # 5. Categorize => by subcategories
    # 6. cat_XXX => Replace with subcategory objects
    # 7. Return
    #------------------------------
    
    #------------------------------
    # 1. Categories
    #------------------------------
    cat_usa = []
    cat_china = []
    cat_others = []
    
    #------------------------------
    # 2. Subcategories
    #------------------------------
    @subcategories = []
    
    # USA
    @subcategories.push(["econ", "others"])
    
    cat_usa_econ = []
    # cat_usa_society = []
    cat_usa_others = []
    
    # cat_usa.push(cat_usa_econ)
    # # cat_usa.push(cat_usa_society)
    # cat_usa.push(cat_usa_others)
    
    # China
    @subcategories.push(["econ", "others"])
    
    cat_china_econ = []
    # cat_china_society = []
    cat_china_others = []
    
    # cat_china.push(cat_china_econ)
    # # cat_china.push(cat_china_society)
    # cat_china.push(cat_china_others)
    
    #------------------------------
    # 3. Keywords
    #------------------------------
    # KW for Categories
    kw_usa = ["アメリカ", "米国", "米"] 
    kw_china = ["中国", "台湾", "日中"]

    # KW for Subcategories
    # USA
    kw_usa_econ = ["景気", "景況", "企業", "経済", "貿易"]
    
    # China
    kw_china_econ = ["経済", "鉄道", "工場"]
    
    #------------------------------
    # 4. Categorize => by categories
    #------------------------------
    # Categorized tags 
    a_tags_categorized = []
#
    a_tags.each do |a_tag|
      #=============================
      # 1. USA
      # 2. China
      # 0. Others
      #=============================
      # Flag
      is_in = false
      
      #
      kw_usa.each do |word|
        #
        if a_tag.content.include?(word)
          cat_usa.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #===================
      # 2. China
      #===================
      kw_china.each do |word|
        #
        if a_tag.content.include?(word)
          cat_china.push(a_tag)
          
          #
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_china.each do |word|
      
      #===================
      # Others
      #===================
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false

      
      
    end#a_tags.each do |a_tag|

    #------------------------------
    # 5. Categorize => by subcategories
    #------------------------------
    # USA -------------------------
    cat_usa.each do |item|
      # Flag
      is_in = false
      
      # Judge
      kw_usa_econ.each do |word|
        #
        if item.include?(word)
        # if item.content.include?(word)  #=> undefined method `content' for []:Array
          cat_usa_econ.push(item)
          
          #
          is_in = true
          
          break
          
        end#if a_tag.content.include?(word)
        
      end#kw_usa_econ.each do |kw|

      # Others
      if is_in == false
        cat_usa_others.push(item)
      end#if is_in == false
            
    end#cat_usa.each do |item|

    # China -------------------------
    cat_china.each do |item|
      # Flag
      is_in = false
      
      # Judge
      kw_china_econ.each do |word|
        #
        if item.include?(word)
          cat_china_econ.content.push(item)
          
          #
          is_in = true
          
          break
          
        end#if a_tag.content.include?(word)
        
      end#kw_china_econ.each do |kw|

      # Others
      if is_in == false
        cat_china_others.push(item)
      end#if is_in == false
            
    end#cat_china.each do |item|

    #------------------------------
    # 6. cat_XXX => Replace with subcategory objects
    #------------------------------
    # USA
    cat_usa = []
    cat_usa.push(cat_usa_econ)
    cat_usa.push(cat_usa_others)
    
    # China
    cat_china = []
    cat_china.push(cat_china_econ)
    cat_china.push(cat_china_others)
    
    # Others
    cat_others_temp = cat_others
    cat_others = []
    cat_others.push(cat_others_temp)
    
    #------------------------------
    # 7. Return
    #------------------------------
    return [cat_usa, cat_china, cat_others]
    
  end#def try18_categorize_overseas(a_tags)
  
  def try_18
    ###########################
    # Steps
    # 1. Get categories
    # 2. Get docs
    # 3. Get a_tags    
    ###########################
    
    #=====================
    # 1. Get categories
    #=====================
    # Param
    @genre = params['genre']

    @categories = []
    
    @cats = Category.find_all_by_genre_id(2)
    
    @cats.each do |cat|
      @categories.push(cat.name)
    end#@cats.each do |cat|

    #=====================
    # 2. Get docs
    #=====================
    # Get doc
    docs = get_docs(5)

    #=====================
    # 3. Get a_tags
    #=====================
    a_tags = get_atags(docs)
    
    
    # Categorize
    a_tags_categorized = try18_categorize_overseas(a_tags)
    
    # Return
    # return a_tags
    return a_tags_categorized
    
  end#def try_18

  # ============ try 19 ========================
  def try19_categorize_overseas(a_tags)
    #------------------------------
    # Steps
    # 1. Categories
    # 2. Subcategories
    # 3. Keywords
    # 4. Categorize => by categories
    # 5. Categorize => by subcategories
    # 6. cat_XXX => Replace with subcategory objects
    # 7. Return
    #------------------------------
    
    #------------------------------
    # 1. Categories
    #------------------------------
    @cat_usa = []
    cat_others = []
    
    #------------------------------
    # 2. Subcategories
    #------------------------------
    subcat_usa = ["econ", "others"]
    
    
    @subcategories = []
    
    # USA
    #@subcategories.push(["econ", "others"])
    @subcategories.push(subcat_usa)
    
    cat_usa_econ = []
    # cat_usa_society = []
    cat_usa_others = []
    
    #------------------------------
    # 3. Keywords
    #------------------------------
    # KW for Categories
    kw_usa = ["アメリカ", "米国", "米"] 
    kw_china = ["中国", "台湾", "日中"]

    # KW for Subcategories
    # USA
    # kw_usa_econ = ["景気", "景況", "企業", "経済", "貿易"]  #kw_china_econ = ["経済", "鉄道", "工場"]
    kw_usa_econ = ["米軍", "景気", "景況", "企業", "経済", "貿易"]  #kw_china_econ = ["経済", "鉄道", "工場"]
    
    #------------------------------
    # 4. Categorize => by categories
    #------------------------------
    # Categorized tags 
    a_tags_categorized = []
#
    a_tags.each do |a_tag|
      #=============================
      # 1. USA
      # 0. Others
      #=============================
      # Flag
      is_in = false
      
      #=============================
      # 1. USA
      #=============================
      #
      kw_usa.each do |word|
        # Jusge
        if a_tag.content.include?(word)
          @cat_usa.push(a_tag)
          
          # Change flag
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #===================
      # Others
      #===================
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false

      
      
    end#a_tags.each do |a_tag|

    #------------------------------
    # 5. Categorize => by subcategories
    #------------------------------
    # USA -------------------------
    @cat_usa.each do |item|
      # Flag
      is_in = false
      
      # Judge
      kw_usa_econ.each do |word|
        #
        #if item.include?(word)
        if item.content.include?(word)  #=> undefined method `content' for []:Array
          cat_usa_econ.push(item)
          
          #
          is_in = true
          
          break
          
        end#if a_tag.content.include?(word)
        
      end#kw_usa_econ.each do |kw|

      # Others
      if is_in == false
        cat_usa_others.push(item)
      end#if is_in == false
            
    end#cat_usa.each do |item|

    #------------------------------
    # 6. cat_XXX => Replace with subcategory objects
    #------------------------------
    # USA
    @cat_usa = []
    @cat_usa.push(cat_usa_econ)
    @cat_usa.push(cat_usa_others)
    
    # Others
    cat_others_temp = cat_others
    cat_others = []
    cat_others.push(cat_others_temp)
    
    #------------------------------
    # 7. Return
    #------------------------------
#    return [cat_usa, cat_china, cat_others]
    return [@cat_usa, cat_others]
    
  end#def try19_categorize_overseas(a_tags)
  
  def try_19
    ###########################
    # Steps
    # 1. Get categories
    # 2. Get docs
    # 3. Get a_tags    
    ###########################
    
    #=====================
    # 1. Get categories
    #=====================
    # Param
    @genre = params['genre']

    @categories = []
    
    @cats = Category.find_all_by_genre_id(2)
    
    @cats.each do |cat|
      @categories.push(cat.name)
    end#@cats.each do |cat|

    #=====================
    # 2. Get docs
    #=====================
    # Get doc
    #docs = get_docs(5)
    docs = get_docs(3)

    #=====================
    # 3. Get a_tags
    #=====================
    a_tags = get_atags(docs)
    
    # Categorize
    a_tags_categorized = try19_categorize_overseas(a_tags)
    
    # Return
    return a_tags_categorized
    
  end#def try_19

  # ============ try 20 ========================
  def try20_categorize_overseas(a_tags)
    #------------------------------
    # Steps
    # 1. Categories
    # 2. Subcategories
    # 3. Keywords
    # 4. Categorize => by categories
    # 5. Categorize => by subcategories
    # 6. cat_XXX => Replace with subcategory objects
    # 7. Return
    #------------------------------
    
    #------------------------------
    # 1. Categories
    #------------------------------
    @cat_usa = []
    cat_others = []
    
    #------------------------------
    # 2. Subcategories
    #------------------------------
    @subcategories = ["econ", "others"]
    
    # USA
    cat_usa_econ = []
    cat_usa_others = []
    
    #------------------------------
    # 3. Keywords
    #------------------------------
    # KW for Categories
    kw_usa = ["アメリカ", "米国", "米"] 

    # KW for Subcategories
    # USA
    kw_usa_econ = ["米軍", "景気", "景況", "企業", "経済", "貿易"]  #kw_china_econ = ["経済", "鉄道", "工場"]
    
    #------------------------------
    # 4. Categorize => by categories
    #------------------------------
    # Categorized tags 
    a_tags_categorized = []
#
    a_tags.each do |a_tag|
      #=============================
      # 1. USA
      # 0. Others
      #=============================
      # Flag
      is_in = false
      
      #=============================
      # 1. USA
      #=============================
      #
      kw_usa.each do |word|
        # Jusge
        if a_tag.content.include?(word)
          @cat_usa.push(a_tag)
          
          # Change flag
          is_in = true
          break
          
        end#if a_tag.content.include?(word)
          
      end#kw_usa.each do |word|
        # else

      #===================
      # Others
      #===================
      if is_in == false
        cat_others.push(a_tag)
      end#if is_in == false

      
      
    end#a_tags.each do |a_tag|

    #------------------------------
    # 5. Categorize => by subcategories
    #------------------------------
    # USA -------------------------
    @cat_usa.each do |item|
      # Flag
      is_in = false
      
      # Judge
      kw_usa_econ.each do |word|
        #
        #if item.include?(word)
        if item.content.include?(word)  #=> undefined method `content' for []:Array
          cat_usa_econ.push(item)
          
          #
          is_in = true
          
          break
          
        end#if a_tag.content.include?(word)
        
      end#kw_usa_econ.each do |kw|

      # Others
      if is_in == false
        cat_usa_others.push(item)
      end#if is_in == false
            
    end#cat_usa.each do |item|

    #------------------------------
    # 6. cat_XXX => Replace with subcategory objects
    #------------------------------
    # USA
    @cat_usa = []
    @cat_usa.push(cat_usa_econ)
    @cat_usa.push(cat_usa_others)
    
    # Others
    cat_others_temp = cat_others
    cat_others = []
    cat_others.push(cat_others_temp)
    
    #------------------------------
    # 7. Return
    #------------------------------
#    return [cat_usa, cat_china, cat_others]
    return [@cat_usa, cat_others]
    
  end#def try20_categorize_overseas(a_tags)
  
  def try_20
    ###########################
    # Steps
    # 1. Get categories
    # 2. Get docs
    # 3. Get a_tags    
    ###########################
    
    #=====================
    # 1. Get categories
    #=====================
    # Param
    @genre = params['genre']

    @categories = []
    
    @cats = Category.find_all_by_genre_id(2)
    
    @cats.each do |cat|
      @categories.push(cat.name)
    end#@cats.each do |cat|

    # Subcategories
    @subcat_usa = ["Econ", "Others"]


    #=====================
    # 2. Get docs
    #=====================
    # Get doc
    #docs = get_docs(5)
    docs = get_docs(3)

    #=====================
    # 3. Get a_tags
    #=====================
    a_tags = get_atags(docs)
    
    # Categorize
    a_tags_categorized = try20_categorize_overseas(a_tags)
    
    # Return
    return a_tags_categorized
    
  end#def try_20

end#class ArticlesController < ApplicationController

# module NokoLib
    # def get_xml_base
      # builder = Nokogiri::XML::Builder.new do |xml|
      # end
#       
      # return Nokogiri::XML(builder.to_xml)
    # end#def get_xml_base
# end

=begin

<!-- USA -------------------->
<hr/>
<div id="<%= @categories[0] %>" class="category" >
  <%= @categories[0] %> (<%= @objects[0].size %> items)
</div>
<hr/>

<% @objects[0].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>
<br/>

<!-- China -------------------->
<hr/>
<div id="<%= @categories[1] %>" class="category" >
  <%= @categories[1] %> (<%= @objects[1].length %> items)
</div>
<hr/>

<% @objects[1].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>

<!-- Europe -------------------->
<hr/>
<div id="<%= @categories[2] %>" class="category" >
  <%= @categories[2] %> (<%= @objects[2].size %> items)
</div>
<hr/>

<% @objects[2].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>

<!-- Korea -------------------->
<hr/>
<div id="<%= @categories[3] %>" class="category" >
  <%= @categories[3] %> (<%= @objects[3].size %> items)
</div>
<hr/>

<% @objects[3].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>

<!-- Middle East -------------------->
<hr/>
<div id="<%= @categories[4] %>" class="category" >
  <%= @categories[4] %> (<%= @objects[4].size %> items)
</div>
<hr/>

<% @objects[4].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>

<!-- India -------------------->
<hr/>
<div id="<%= @categories[5] %>" class="category" >
  <%= @categories[5] %> (<%= @objects[5].size %> items)
</div>
<hr/>

<% @objects[5].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>


<!-- Others -------------------->
<hr/>
<div id="<%= @categories[6] %>" class="category" >
  <%= @categories[6] %> (<%= @objects[6].size %> items)
</div>
<hr/>

<% @objects[6].each do |item| %>
  <%#= raw item.to_html %>
  <%# item.each do |article| %>
    <div style="line-height: 250%;">
      <%#= raw item[0] %>
      <%#= raw article %>
      <%= raw item %><br/>
      <%#= item.content %>
    </div>
  <%# end %>
<% end %>

=end