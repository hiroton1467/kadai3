class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @users = User.all
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user.id)
    end
  end

  def create
     @book = Book.new(book_params)
   if @book.save
     flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
   else
     @books = Book.all
     render :index
   end
  end

  def update
       @user = User.find(current_user.id)
   if  @user.update(user_params)
       flash[:notice] = "successfully updated."
       redirect_to user_path(@user.id)
   else
       render :edit
   end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end
