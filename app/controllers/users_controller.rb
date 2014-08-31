class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout "master"

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.confirmed = false
    @user.salt = BCrypt::Engine.generate_salt
    @user.password = BCrypt::Engine.hash_secret(@user.password, @user.salt)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /users/login
  def login
    if session[:current_user_id]
    end
  end

  # POST /users/login
  def authenticate
    @user = authenticate_credentials(params[:email],params[:password])
    if @user
      session[:current_user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_users_path, notice: "Your credentials don't match."
    end
  end

  def logout
    session[:current_user_id] = nil
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :birthdate, :address, :credit_card, :phone, :email, :password, :confirmed, :newsletter)
    end

    # Use this to authenticate a user, it returns a user if it matches, otherwise will return nil
    def authenticate_credentials(email, password)
      # hashed_password is the password obtained using the email and password parameters
      hashed_password = BCrypt::Engine.hash_secret(password, User.find_by_email(email).salt)

      @user = User.where("email = ? and password = ?", email, hashed_password).first!

      return @user
    end
end