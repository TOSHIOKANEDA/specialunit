class AcceptingsController < ApplicationController

def new
end

def create
  Accepting.create(accepting_params)
  redirect_to action: 'show'
end


def show
  @accepting = Accepting.all
end



def destroy
  @accepting = Accepting.find(params[:id])
  @accepting.destroy
  redirect_to "/acceptings/new", alert: "削除しました"
end

private
def accepting_params
  params.permit(:place, :kind, :week, :year)
end
end