class AcceptingsController < ApplicationController

def new
end

def create
  Accepting.create(accepting_params)
end

可否状況のアップデートを行う画面を作成する際に使う

def show
  @accepting = Accepting.all
end

def update
  accepting = Accepting.find(params[:id])
  accepting.update(accepting_params)
end

def destroy
  @accepting = Accepting.find(params[:id])
  @accepting.destroy
  redirect_to action: 'new'
end

private
def accepting_params
  params.permit(:place, :kind, :week, :year)
end
end