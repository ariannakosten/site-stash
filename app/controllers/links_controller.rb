class LinksController < ApplicationController
  # lets a user view all linkss if logged in
  # redirects to login page if not logged in
  get '/links' do
    if logged_in?
      @links = Link.all
      erb :'links/index'
    else
      redirect '/login'
    end
  end

  # lets user create link if they are logged in
  get '/links/new' do
    if logged_in?
      erb :'/links/new'
    else
      redirect '/login'
    end
  end

  # does not let a user create a blank link details
  post '/links' do
    if params[:link_name] == "" || params[:link_description] == "" || params[:category_name] == ""
      flash[:field_error] = "All fields must be filled out"
      redirect to "/links/new"
    else
      @user = current_user
      @category = Category.find_or_create_by(name: params[:category_name])
      @link = Link.create(name: params[:link_name], description: params[:link_description], category_id: @category.id, user_id: @user.id)
      redirect to "/links"
    end
  end

  # displays 1 link
  get '/links/:id' do
    if logged_in?
      #binding.pry
      @link = Link.find_by(id: params[:id])
      @category = @link.category
      erb :'links/show'
    else
      redirect '/login'
    end
  end

  # lets a user view link edit form if they are logged in
  # does not let a user edit a link he/she did not create
  get '/links/:id/edit' do
    if logged_in?
      @link = Link.find(params[:id])
      @category = Category.find(@link.category_id)
        erb :'links/edit'
      else
        redirect '/home'
      end
    end


  # does not let a user edit a text with blank content
  patch '/links/:id' do
    
    if params[:link_name] != "" && params[:link_description] != "" && params[:category_name] != ""
      @link = Link.find_by(id: params[:id])
      @link.update(name: params[:link_name], description: params[:link_description])
      @category = @link.category
      @category.name =  params[:category_name]
      @link.save
      @category.save
      redirect "/links/#{@link.id}"
    else
      flash[:feild_error] = "All fields must be filled out"
      redirect to "/links/#{params[:id]}/edit"
    end
  end
  
  
  delete '/links/:id/delete' do 
    if !logged_in?
      redirect to '/login'
    else
    @link = Link.find(params[:id])
    @link.destroy
    flash[:field_error] = "Your link has been deleted"
      redirect to '/links'
    end 
  end
end

  # lets a user delete their own link if they are logged in
  # does not let a user delete a link they did not create
  

#   get '/links' do
#     if logged_in?
#       @user = current_user
#       @links = @user.links
#       # @links = Link.all
#       erb :'links/index'
#     else
#       redirect '/login'
#     end
#   end
  
#   post '/links' do
#     @user = current_user
#     if params[:name] == "" || params[:description] == "" || params[:category] == "" 
#       redirect to '/links/new'
#     end
#       @link = @user.links.create(name: params[:name], description: params[:description], category: params[:category])
#     redirect to '/links'
#   end 
  
#   get '/links/:id/edit' do
#     if !logged_in?
#       redirect to '/login'
#     end
#     @link = Link.find(params[:id])
#     erb :"links/edit"
#   end
  
#   patch '/links/:id' do
#     link = Link.find(params[:id])
#     if params[:name] == "" || params[:description] == "" || params[:category] == "" 
#       redirect to "/links/#{params[:id]}/edit"
#     end
#     link.update(name: params[:name], description: params[:description], category: params[:category])
 
#     redirect to "/links/#{link.id}"
#   end

  

# end =====================================================

#   get "/links/:id/edit" do  
#   logged_in? 
#     @link = Link.find(params[:id])
#     erb :'links/edit'
#   end
  
#   patch '/links/:id' do   
#     @link = Link.find_by_id(params[:id])    
#     @link.update(params[:link])
        
#       redirect "/links/#{@link.id}"
#   end
#   # @link.update(params.select{|k|k=="name" || k=="description" || k=="category"})

#   get "/links/:id" do
#     logged_in? 
#     @link = Link.find(params[:id])
#     erb :'links/show'
#   end

#   post "/links" do    
#     logged_in? 
#     Link.create(params[:link][:category])
#     redirect "/links"
#   end
  

# ==============
  
 
  
  # get '/links/new' do
  #   if logged_in?
  #     @categories = Category.all
  #     #@categories = @user.categories.uniq.sort_by { |category| category.title }
  #     erb :'links/new'
  #   else 
  #     redirect '/login'
  #   end
  # end
  
  # # post '/links' do
  #   if params[:link][:description] == "" || params[:link][:name] == ""
  #     redirect '/links/new'
  #   else
  #     link = @user.links.create(params[:link])
  #     link.categories << Category.find_or_create_by(title: params[:category][:title]) if !params[:category][:title].empty?
  #     redirect '/links'
  #   end
  # end
  
  # get '/links/:id' do
  #   if logged_in?
  #     @link = Link.find_by_id(params[:id])
  #     erb :'links/show'
  #   else
  #     redirect '/login'
  #   end
  # end
  
  # get '/links/:id/edit' do
  #   if logged_in?
  #     @link = Link.find_by_id(params[:id])
  #     @categories = @user.categories.uniq.sort_by { |category| category.title }
  #     erb :'links/edit'
  #   else
  #     redirect '/login'
  #   end
  # end
  
  # patch '/links/:id' do
  #   @link = Link.find_by_id(params[:id])    
  #   if params[:link][:description] == "" || params[:link][:name] == ""
  #     redirect "/links/#{@link.id}/edit"
  #   else
  #     @link.update(params[:link])
  #     @link.categories << Category.find_or_create_by(title: params[:category][:title]) if !params[:category][:title].empty?
  #     redirect "/links/#{@link.id}"
  #   end
  # end
  
  