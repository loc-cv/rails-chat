class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_info, only: %i[index show]

  def index; end

  def show
    @active_room = Room.find(params[:id])
    @message = Message.new # for the message input
    @messages = @active_room.messages.order(created_at: :asc)
    render :index
  end

  def create
    @room = Room.create(room_params)
  end

  private

  def set_info
    @room = Room.new # for the new room in room index view
    @public_rooms = Room.public_rooms
    @other_users = User.all_except(current_user)
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
