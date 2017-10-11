require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts' do
    @posts = Post.all #inherited from...somewhere
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    post = Post.create(params)

    redirect '/posts' #calls the get '/posts' earlier action
  end

  get '/posts/:id' do
    @post = Post.find(params[:id]) #params[:id], not just :id. Needs to grab from params hash, not the url
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do #edit action
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect to "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.delete

    erb :delete
  end

end
