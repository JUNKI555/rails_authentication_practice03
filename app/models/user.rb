# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  nickname   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  devise :authenticatable

  has_one :user_database_authentication, dependent: :destroy
  has_one :user_tracking, dependent: :destroy
  has_one :user_recover, dependent: :destroy
end
