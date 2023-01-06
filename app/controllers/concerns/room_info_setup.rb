module RoomInfoSetup
  extend ActiveSupport::Concern

  included do
    before_action :set_public_info, only: %i[index show]
    before_action :set_new_room, only: %i[index show]
    before_action :set_new_message, only: %i[show]
  end

  private

  def set_public_info
    @public_rooms = Room.public_rooms
    @other_users = User.all_except(current_user)
  end

  # For the new room form in room index view
  def set_new_room
    @room = Room.new
  end

  # For the message input
  def set_new_message
    @message = Message.new
  end
end
