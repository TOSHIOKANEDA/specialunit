class AcceptingsController < ApplicationController

def new
end

def create
  @accepting = Accepting.new(accepting_params)
  @accepting[:week] = accepting_params[:week][-2..-1]
  @accepting[:year] = accepting_params[:week][0..3]
  @accepting.save
  redirect_to action: 'show'
end


def show
  @acceptings = Accepting.all
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