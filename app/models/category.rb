class Category < ActiveRecord::Base
  #==========================
  # Relations
  #==========================
  #
  belongs_to :genre
  has_many :subcat  

end#class Category
