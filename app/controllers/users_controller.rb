class UsersController < ApplicationController
  include RoomInfoSetup

  def show
    @user = User.find(params[:id])
    @room_name = get_room_name(@user, current_user)
    @active_room = Room.find_by(name: @room_name) || Room.create_private_room([@user, current_user], @room_name)
    @messages = @active_room.messages.order(created_at: :asc)
    render "rooms/index"
  end

  private

  def get_room_name(first_user, second_user)
    users = [first_user, second_user].sort
    "private_#{users[0].id}_#{users[1].id}"
  end
end
