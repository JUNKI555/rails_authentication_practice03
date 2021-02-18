# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /users/confirmation/new
  def new
    super
  end

  # POST /users/confirmation
  def create()
    registered = UserDatabaseAuthentication.where(email: params[:user_registration][:email]).exists?

    if registered
      flash[:error] = '既に登録されているメールアドレスです。'
      return render :new
    end

    user_registration = UserRegistration.find_or_initialize_by(unconfirmed_email: params[:user_registration][:email])
    if user_registration.save
      super
    else
      flash[:error] = '処理に失敗しました。もう一度お試しください。'
      return render :new
    end
  end

  # GET /users/confirmation?confirmation_token=abcdef
  def show
    # super 側で confirmation_token　の検証をしてリダイレクト
    super
  end

  protected

   # 確認メールを送信した後に使用する path
  def after_resending_confirmation_instructions_path_for(resource_name)
    root_path
  end

  # 確認後に使用する path
  def after_confirmation_path_for(resource_name, resource)
    new_user_database_authentication_registration_path
  end
end
