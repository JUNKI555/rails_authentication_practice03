# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  def new
    super
  end

  # POST /users
  def create
    ActiveRecord::Base.transaction do
      @user = User.new(nickname: params[:nickname])
      @user.save!
      @user_database_authentication = \
        UserDatabaseAuthentication.new( \
          user: @user, \
          email: params[:user_database_authentication][:email], \
          password: params[:user_database_authentication][:password], \
          password_confirmation: params[:user_database_authentication][:password_confirmation])
      @user_database_authentication.save!
    end

    sign_in(:user, @user)
    sign_in(:database_authentication, @user_database_authentication)

    redirect_to root_path
  rescue
    flash[:alert] = '処理に失敗しました。もう一度お試しください。'
    return render :new
  end

  # GET /users/edit
  def edit
    super
  end

  # PUT /users
  def update
  # 更新処理しようとするとなぜか user をSELECTして例外になる
  #   if !resource.valid_password?(account_update_params[:current_password])
  #     flash[:alert] = 'Current password が間違っています'
  #     return render :edit
  #   end

  #   resource.update_with_password(account_update_params)

  #   flash[:notice] = '更新しました'
  #   redirect_to root_path

  # rescue
  #   flash[:alert] = '処理に失敗しました。もう一度お試しください。'
  #   return render :edit
  end

  # DELETE /users
  def destroy
    super
  end

  # GET /users/cancel
  # 通常はサインイン後に
  # 期限切れになるセッションデータを強制的に今すぐ期限切れにします。
  # これは、ユーザーがすべての OAuth セッションデータを削除して、
  # 途中で oauth サインイン/アップをキャンセルしたい場合に便利です。
  def cancel
    super
  end

  protected

  # 許可するための追加のパラメータがある場合は、sanitizer に追加してください
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # 許可するための追加のパラメータがある場合は、sanitizer に追加してください
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # サインアップ後に使用する path
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # アクティブでないアカウントのサインアップ後に使用する path
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
