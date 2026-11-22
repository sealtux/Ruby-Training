class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = accessible_events.order(starts_at: :asc)
  end

  def show; end

  def new
    @event = accessible_events.new(starts_at: Time.current.change(min: 0) + 1.day)
    build_guest_fields
  end

  def create
    @event = accessible_events.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event created. Your guest list is ready."
    else
      build_guest_fields
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    build_guest_fields
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated."
    else
      build_guest_fields
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    redirect_to events_path, notice: "Event deleted.", status: :see_other
  end

  private

  def set_event
    @event = accessible_events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :location, :description, :starts_at, :ends_at,
      guests_attributes: [:id, :name, :email, :_destroy])
  end

  def build_guest_fields
    (3 - @event.guests.length).times { @event.guests.build }
  end
end
