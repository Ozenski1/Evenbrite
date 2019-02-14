class ParticipationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :index, :show]

  def index
    @event = Event.find(params[:event_id])
    @attendances = @event.attendances
  end

  def show
  end

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(
        stripe_customer_id: params[:stripeToken],
        event_id: params[:event_id],
        user_id: current_user.id)

    if @attendance.save
      flash[:success] = "SAVE!"
      redirect_to event_path(@event.id)
    else
      flash[:error] = "ERROR!"
      render :new
    end

    # Amount in cents
    @amount = @event.price

    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @event
  end

end