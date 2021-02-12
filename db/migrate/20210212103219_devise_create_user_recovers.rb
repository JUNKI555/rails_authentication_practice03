# frozen_string_literal: true

class DeviseCreateUserRecovers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_recovers do |t|
      t.references :user, foreign_key: true, dependent: :destroy,  index: {unique: true}

      ## Recoverable
      t.string   :reset_password_token, null: false
      t.datetime :reset_password_sent_at, null: false

      t.timestamps null: false
    end
  end
end
