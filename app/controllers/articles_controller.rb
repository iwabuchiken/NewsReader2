#coding:utf-8
###coding:euc-jp
require 'basics'
require 'noko_helper'

class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json

  # @categories = []
    
  def index
    
    @objects = try_nokogiri_16    # Modify link

    # @testword = "体積"  #=================================
    
    
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

  private #================================
  
  def get_xml_base
    builder = Nokogiri::XML::Builder.new do |xml|
    end
    
    return Nokogiri::XML(builder.to_xml)
  end#def get_xml_base
    
  def try_nokogiri_1
    # NokoHelper
    noko_helper = NokoHelper::NokoHelper.new
    
    # Get base
    xml_base = NokoHelper::NokoHelper.new.get_xml_base
    
    # Get node
    node1 = noko_helper.get_node(xml_base, "LinearLayout")
    
    # Add child
    noko_helper.add_child(xml_base, node1)
    
    # Set attributes
    noko_helper.set_attribute(
            node1, 
            "xmlns:android", "http://schemas.android.com/apk/res/android")
    
    # Add another child
    # node2 = noko_helper.get_node(xml_base, "Button")
    # noko_helper.set_attribute(
            # node2, 
            # "android:orientation", "vertical")
    # # noko_helper.add_child(xml_base, node2)
    # noko_helper.add_next_sibling(xml_base, node2)
    
    return xml_base
     
  end#def try_nokogiri_1

  def try_nokogiri_2
    return NokoHelper::HTMLParser.new.open_html("http://headlines.yahoo.co.jp/hl?c=soci&t=l")
  end#def try_nokogiri_2
  
  def try_nokogiri_3
    doc = try_nokogiri_2
    
    # a_tags = doc.xpath("//a")
    # a_tags = doc.css("//a")
    
    tags = doc.css("div ul li a")
    
    return tags
    # return a_tags
    # return doc
  end

  # ============ try 4 ========================
  def get_html_doc(url)
    return NokoHelper::HTMLParser.new.open_html(url)
  end#def get_html_doc(url)
  
  def try_nokogiri_4
    # Url
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l"
    
    doc = get_html_doc(url)
    
    tags = doc.css("div ul li a")
    
    # Get new tags
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=1"
    doc = get_html_doc(url)
    tags_2 = doc.css("div ul li a")
    
    # Append the new tags   => 2
    tags_2.each do |tag|
      tags.push(tag)
    end
    
    # Get new tags
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=2"
    doc = get_html_doc(url)
    tags_2 = doc.css("div ul li a")
    
    # Append the new tags
    tags_2.each do |tag|
      tags.push(tag)
    end
    
    # Get new tags          => 3
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=3"
    doc = get_html_doc(url)
    tags_2 = doc.css("div ul li a")
    
    # Append the new tags
    tags_2.each do |tag|
      tags.push(tag)
    end

    # # Iteration
    # 5.times do |i|
      # # Next page
      # # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=1"
      # # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=" + i.to_s
      # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=" + (i + 1).to_s
#       
      # doc = get_html_doc(url)
#       
      # tags_2 = doc.css("div ul li a")
#       
      # # Append new tags
      # tags_2.each do |tag|
        # tags.push(tag)
      # end
    # end
      
    
    return tags
    # return a_tags
    # return doc
  end#def try_nokogiri_4

  # ============ try 5 ========================
  def try_nokogiri_5
    # Url
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l"
    
    doc = get_html_doc(url)
    
    tags = doc.css("div ul li a")
    
    # Get new tags
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=1"
    doc = get_html_doc(url)
    tags_2 = doc.css("div ul li a")
    
    # Append the new tags   => 2
    tags_2.each do |tag|
      tags.push(tag)
    end
    
    # Get new tags
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=2"
    doc = get_html_doc(url)
    tags_2 = doc.css("div ul li a")
    
    # Append the new tags
    tags_2.each do |tag|
      tags.push(tag)
    end
    
    # Get new tags          => 3
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=3"
    doc = get_html_doc(url)
    tags_2 = doc.css("div ul li a")
    
    # Append the new tags
    tags_2.each do |tag|
      tags.push(tag)
    end
    
    return tags
    # return a_tags
    # return doc
  end#def try_nokogiri_5

  # ============ try 6 ========================
  def get_tags()
    # Url
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l"
    
    doc = get_html_doc(url)
    
    tags = doc.css("div ul li a")
    
    # # Get new tags
    # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=1"
    # doc = get_html_doc(url)
    # tags_2 = doc.css("div ul li a")
#     
    # # Append the new tags   => 2
    # tags_2.each do |tag|
      # tags.push(tag)
    # end
#     
    # # Get new tags
    # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=2"
    # doc = get_html_doc(url)
    # tags_2 = doc.css("div ul li a")
#     
    # # Append the new tags
    # tags_2.each do |tag|
      # tags.push(tag)
    # end
#     
    # # Get new tags          => 3
    # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=3"
    # doc = get_html_doc(url)
    # tags_2 = doc.css("div ul li a")
#     
    # # Append the new tags
    # tags_2.each do |tag|
      # tags.push(tag)
    # end
  
    return tags    
  end#def get_tags()
  
  def try_nokogiri_6
    tags = get_tags
    
    # # Modify the tags
    # tags.each do |tag|
      # if tag['href'].start_with?("/hl?")
#         
      # end
      # # tags_new
    # end
    
    return tags
    # return a_tags
    # return doc
  end#def try_nokogiri_6

  # ============ try 7 ========================
  def try_nokogiri_7
    # NodeSet
    #tags = Nokogiri::XML::NodeSet.new
    
    # Thread 1
    th1 = Thread.new do
      tags = get_tags
    end
    #tags = get_tags
    
    # # Modify the tags
    # tags.each do |tag|
      # if tag['href'].start_with?("/hl?")
#         
      # end
      # # tags_new
    # end
    
    return tags
    # return a_tags
    # return doc
  end#def try_nokogiri_7

  # ============ try 8 ========================
  def try_nokogiri_8
    # Urls
    urls = [
      "http://headlines.yahoo.co.jp/hl?c=soci&t=l",
      "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=1"
    ]
    
    # HTML docs
    docs = []
    
    # Thread array
    threads = []
    
    # Get docs
    2.times do |i|
      # Get docs
      threads << Thread.start(i, urls) do
        # puts "Thred #{i.to_s}: " + urls[i] 
        docs[i] = Nokogiri::HTML(open(urls[i]))
      end
    
      # Join
      threads.each do |t|
        t.join
      end
    end
    
    # Return
    return docs
    # return docs
    
  end#def try_nokogiri_8

  # ============ try 9 ========================
  def try_nokogiri_9
    # # Urls
    # urls = [
      # "http://headlines.yahoo.co.jp/hl?c=soci&t=l",
      # "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p=1"
    # ]
    
    # Urls
    url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p="
    
    # HTML docs
    docs = []
    
    # Thread array
    threads = []
    
    # Get docs
    # 2.times do |i|
    5.times do |i|
      # Get docs
      # threads << Thread.start(i, urls) do
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
    # return docs
    
  end#def try_nokogiri_9

  # ============ try 10 ========================
  def try_nokogiri_10
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
    5.times do |i|
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
    
  end#def try_nokogiri_10
  
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
  
  def try_nokogiri_11
    # Get doc
    #docs = get_docs(3)
    docs = get_docs(1)
    
    # Modify
    docs.each do |doc|
      # Get 'a' tags
      a_tags = doc.css("div ul li a")
      
      # href value
      a_tags.each do |a_tag|
        if a_tag['href'].start_with?("/hl?")
          a_tag['href'] = "http://headlines.yahoo.co.jp" + a_tag['href']
        end
      end
      
    end
    
    return docs
    
#    # Get params
#    genre = params['genre']
#    
#    # Urls
#    if genre != nil
#      # url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p="
#      url = "http://headlines.yahoo.co.jp/hl?c=#{genre}&t=l&p="
#    else
#      url = "http://headlines.yahoo.co.jp/hl?c=soci&t=l&p="
#    end
#    
#    # HTML docs
#    docs = []
#    
#    # Thread array
#    threads = []
#    
#    # Get docs
#    # 2.times do |i|
#    5.times do |i|
#      # Get docs
#      threads << Thread.start(i, url) do
#        # puts "Thred #{i.to_s}: " + urls[i] 
#        # docs[i] = Nokogiri::HTML(open(urls[i]))
#        docs[i] = Nokogiri::HTML(open(url + (i + 1).to_s))
#      end
#    
#      # Join
#      threads.each do |t|
#        t.join
#      end
#    end
#    
#    # Return
#    return docs
    
  end#def try_nokogiri_11

  # ============ try 12 ========================
  def try_nokogiri_12
    # Get doc
    #docs = get_docs(3)
    #docs = get_docs(1)
    docs = get_docs(5)
    
    #meta_tags
    meta_tags = nil
    
    # New docs
    docs_new = []
    
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
          
        end#if a_tag['href'].start_with?("/hl?")
      end#a_tags.each do |a_tag|
      
      #--------------------
      # Modify 'charset' value
      #--------------------
      
      # Get 'meta' tags
      meta_tags = doc.css("//meta")
      
      #debug
#      return meta_tags
      
      # Include?
      meta_tags.each do |meta_tag|
        #if meta_tag['content'] == "text/html; charset=euc-jp"
        if meta_tag['content'].include?("text/html; charset=euc-jp")
          meta_tag['content'] = "text/html; charset=utf-8"
        end
      end
#      
    end#docs.each do |doc|
    
    #debug
#    return meta_tags
    
#    
    return docs
    # return docs_new
    
  end#def try_nokogiri_12

  # ============ try 13 ========================
  def try_nokogiri_13
    # Get doc
    #docs = get_docs(3)
    #docs = get_docs(1)
    docs = get_docs(5)
    
    #meta_tags
    meta_tags = nil
    
    # New docs
    docs_new = []
    
    # Modify
    docs.each do |doc|
      #--------------------
      # Modify 'a' tags
      #--------------------
      
      # Get 'a' tags
      a_tags = doc.css("div ul li a")
      
      # href a tags
      a_tags_href = []
      
      # href value
      a_tags.each do |a_tag|
        if a_tag['href'].start_with?("/hl?")
          # Modify url
          a_tag['href'] = "http://headlines.yahoo.co.jp" + a_tag['href']
          
          # Add
          a_tags_href.push(a_tag)
          
        end#if a_tag['href'].start_with?("/hl?")
      end#a_tags.each do |a_tag|
      
      # New doc
      docs_new.push(a_tags_href)
      
      #--------------------
      # Modify 'charset' value
      #--------------------
      
      # Get 'meta' tags
      meta_tags = doc.css("//meta")
      
      #debug
#      return meta_tags
      
      # Include?
      meta_tags.each do |meta_tag|
        #if meta_tag['content'] == "text/html; charset=euc-jp"
        if meta_tag['content'].include?("text/html; charset=euc-jp")
          meta_tag['content'] = "text/html; charset=utf-8"
        end
      end
#      
    end#docs.each do |doc|
    
    #debug
#    return meta_tags
    
#    
    # return docs
    return docs_new
    
  end#def try_nokogiri_13

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