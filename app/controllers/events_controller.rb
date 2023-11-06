class EventsController < ApplicationController
  before_action :set_event, only: [:destroy]

  def index
    date_param = params[:date]
    if date_param
      @events = Event.where('DATE(start_time) = ?', date_param)
    else
      @events = Event.all
    end
    render json: @events
  end


  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time)
  end
end
