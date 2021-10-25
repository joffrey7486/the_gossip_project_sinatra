require 'gossip'

class ApplicationController < Sinatra::Base

  # montre tout les messages dans le menu
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # page pour créer un nouveau gossip
  get '/gossips/new/' do
    erb :new_gossip
  end

  # créer un nouveau gossip
  post '/gossips/new/' do  
    Gossip.new("#{params["gossip_author"]}", "#{params["gossip_content"]}").save
    redirect '/'
  end

  # montre les messages dont l'id de l'url correspondant à la ligne de la bd
  get "/gossips/:id/" do
    erb :show, locals: {gossip_n: Gossip.find(params['id'].to_i), id: params['id']}
  end

  get "/gossips/:id/edit/" do
    erb :edit, locals: {id: params['id']}
  end
  
  post "/gossips/:id/edit/" do
    Gossip.update(params["gossip_new_author"], params["gossip_new_content"], params["id"].to_i)
    redirect "/"
  end
end

