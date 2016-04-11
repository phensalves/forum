class Comment < ActiveRecord::Base
	validates :author, :presence => true
	validates :body, :presence => true
	validate :check_blacklist

  belongs_to :post

  def check_blacklist
  	@blacklist ||= File.read('blacklist.txt').split
  	errors.add_to_base("#{word} is a ugly word! Try a beautiful word!") if @blacklist.include? include word 
  end

end
