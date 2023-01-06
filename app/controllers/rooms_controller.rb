class RoomsController < ApplicationController
  include RoomInfoSetup

  before_action :authenticate_user!

  def index; end

  def show
    @active_room = Room.find(params[:id])
    @messages = @active_room.messages.order(created_at: :asc)
    render :index
  end

  def create
    @room = Room.create(room_params)
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
