# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  content    :text             not null
#  post_id    :integer          not null
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates_presence_of :author, :post, :content

  belongs_to :author, foreign_key: :user_id, class_name: :User
  belongs_to :post

  has_many :child_comments,
    foreign_key: :comment_id,
    class_name: :Comment,
    dependent: :destroy
end
