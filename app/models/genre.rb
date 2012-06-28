class Genre < ActiveRecord::Base
  #==========================
  # Relations
  #==========================
  #
  has_many :category

end#class Genre
