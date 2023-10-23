class UsersController <ApplicationController 
  def new 
    @user = User.new
  end 
  def show 
    @user = User.find(params[:id])
  end 

  def create
    new_user = User.create(user_params)
    if new_user.save
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end

  def login_form

  end

  def login
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if user
      flash[:success] = "Welcome, #{user.name}!"
      session[:user_id] = user[:id]
      redirect_to user_path(user)
    else
      flash[:error] = "Credentials are incorrect"
      redirect_to login_path
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 