require "pry"

class FiguresController < ApplicationController

  set :views, Proc.new { File.join(root, "../views/figures") }

  get "/figures" do
    @figures = Figure.all
    erb :index
  end

  get "/figures/new" do
    erb :new
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :show
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :edit
  end

  post "/figures/new" do
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect "/figures"
  end

  post '/figures/:id' do
      @figure = Figure.find_by(id: params[:id])
      @figure.titles.clear
      @figure.landmarks.clear
      @figure.update(name: params[:figure][:name])

      create_or_update_landmark(params[:figure][:landmark_ids], params[:landmark][:name])
      create_or_update_title(params[:figure][:title_ids], params[:title][:name])

      @figure.save

      redirect "/figures/#{@figure.id}"
    end

end
