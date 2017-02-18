# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
  validates_presence_of :post, :sub
  validates :sub_id, uniqueness: {scope: :post_id, message: "Cannot post to the same sub twice!"}

  belongs_to :post, inverse_of: :post_subs
  belongs_to :sub
end
