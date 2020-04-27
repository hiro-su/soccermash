class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order('rating DESC')
  end

  def compare
    @users = User.all.sample(2)
  end

  def calc
    user_a = User.find(params[:user_a])
    user_b = User.find(params[:user_b])
    if params[:winner].to_i == user_a.id
      user_a_new_rating = elorating(1, user_a.rating, user_b.rating)
      user_b_new_rating = elorating(0, user_b.rating, user_a.rating)
    else
      user_b_new_rating = elorating(1, user_b.rating, user_a.rating)
      user_a_new_rating = elorating(0, user_a.rating, user_b.rating)
    end
    user_a.rating = user_a_new_rating
    user_b.rating = user_b_new_rating
    user_a.save
    user_b.save
    redirect_to "/"
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :rating, :url)
    end

    # win: 1, lose: 0
    def elorating(score, rating, opponent_rating)
      k = 32
      e = 1.0 / (1 + 10 ** ((opponent_rating - rating) / 400))
      rating + k * (score - e)
    end
end
