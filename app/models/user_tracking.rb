# == Schema Information
#
# Table name: user_trackings
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :string(255)
#  sign_in_count      :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#
# Indexes
#
#  index_user_trackings_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserTracking < ApplicationRecord
  devise :trackable

  belongs_to :user
end
