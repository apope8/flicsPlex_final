class CartController < ApplicationController
  before_action :authenticate_user!
  def index
    #pass the information to the view page of the cart
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end
  
  def add
    
    #get the id of the prodyce we want to add
    
    id = params[:id]
    
    # if the session is already there use that if not make a new session
    
    if session[:cart]
      cart = session[:cart]
    else
      #if not logged in create an empty array
      session[:cart] = {}
      cart = session[:cart]
    end
    
    #if the product is already in the cart then increase the products quantity by one
    
    if cart[id] then
      cart[id] = cart[id] + 1
    else
      cart[id] = 1
    end
    
    redirect_to :action => :index
    
  end
  
  def remove
    #define a method to remove an item from the cart
    
    id = params[:id]
    cart = session[:cart]
      if cart[id] == 1 then
        cart.delete id
      else
      cart[id] = cart[id] - 1
    end
    #cart.delete id
    
    redirect_to :action => :index
    
  end
  
  def createOrder
    
    #Step 1 : Get current users id
    
    @user = User.find(current_user.id)
    
    #pushes order into db table
    @user.save
    
    #Step 2 : Build an order based on current user and their order stats
    
    @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
    
    @order.save
    
    #Step 3 : Move cart items to now be orderitems
    
    @cart = session[:cart] || {} # Get content of current cart
    
    @cart.each do |id, quantity|
      movie = Movie.find_by_id(id)
      
      @orderitem = @order.orderitems.build(:item_id => movie.id, :title => movie.title, :description => movie.description, 
      :quantity => quantity, :price => movie.price)
      
      @orderitem.save
    
    end
    
    #give variable @orders all data in order table
    @orders = Order.all
    
    #give variable @ordersItems the last order entered into the orderItem table
      @orderitems = Orderitem.where(order_id: Order.last) 
  
  end
  
  def clearCart
    session[:cart] = nil
    
    redirect_to :action => :index
  end
    
  
end
