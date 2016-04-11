class Comment < ActiveRecord::Base
	validates :author, :presence => true
	validates :body, :presence => true

	default_scope -> { order(updated_at: :desc) }

  belongs_to :post
end
