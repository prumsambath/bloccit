class Vote < ActiveRecord::Base
  after_save :update_post
  belongs_to :user
  belongs_to :post

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }

  private

  def update_post
    post.update_rank
  end
end
