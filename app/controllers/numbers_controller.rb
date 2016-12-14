require 'data_parser.rb'

class NumbersController < ApplicationController
  before_action :set_number, only: [:destroy]

  # GET /numbers
  # GET /numbers.json
  # def index
  #   @numbers = Number.all
  # end

  # GET /numbers/1
  # GET /numbers/1.json
  # def show
  # end

  # GET /numbers/new
  def new
    @number = Number.new
  end

  # GET /numbers/1/edit
  # def edit
  # end

  # POST /numbers
  # POST /numbers.json
  def create
    @number = Number.new(number_params)
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
    @client.account.messages.create({
      :from => ENV['TWILIO_NUMBER'],
      :to => @number.tocall,
      :body => 'hey, it works!',
    })

    respond_to do |format|
      if @number.save
        format.html { redirect_to @number, notice: 'Number was successfully created.' }
        format.json { render :show, status: :created, location: @number }
      else
        format.html { render :new }
        format.json { render json: @number.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /numbers/1
  # PATCH/PUT /numbers/1.json
  # def update
  #   respond_to do |format|
  #     if @number.update(number_params)
  #       format.html { redirect_to @number, notice: 'Number was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @number }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @number.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /numbers/1
  # DELETE /numbers/1.json
  def destroy
    @number.destroy
    respond_to do |format|
      format.html { redirect_to numbers_url, notice: 'Number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number
      @number = Number.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_params
      params.require(:number).permit(:tocall)
    end
end
