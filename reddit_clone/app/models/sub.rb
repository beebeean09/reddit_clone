# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
  validates_presence_of :title, :description, :moderator

  has_many :posts, dependent: :destroy
  belongs_to :moderator, foreign_key: :user_id, class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :cross_posts, through: :post_subs, source: :post
end
