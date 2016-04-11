class Post < ActiveRecord::Base
	validates :name,  :presence true
	validates :title, :presence true, :length => { :minimum => 6 }

	has_many :comments

end
