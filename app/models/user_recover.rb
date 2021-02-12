# == Schema Information
#
# Table name: user_recovers
#
#  id                     :bigint           not null, primary key
#  reset_password_sent_at :datetime         not null
#  reset_password_token   :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint
#
# Indexes
#
#  index_user_recovers_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserRecover < ApplicationRecord
  devise :recoverable

  belongs_to :user
end
