class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
    
  end

  def help
  end

  def about
  end
  
  def category
    
    catName = params[:title]
    @movies = Movie.where("genre like ?", catName)
  end
  
  def paid
    
    @order = Order.last
    
    @order.update_attribute(:status, "Paid in full by #{current_user.email}")
    
  end
end
