class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /plays
  # GET /plays.json
  def index
    if current_user
      @plays = current_user.plays.all.order('created_at DESC')
    else 
      @plays = Play.all.order('created_at DESC')
    end

    unless params[:category].blank?
      @category_id = Category.find_by(name: params[:category]).id
      @plays = @plays.where(:category_id => @category_id).order('created_at DESC')
    end
    
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
    @avg_rating = 0
    unless @play.reviews.blank?
      @avg_rating = @play.reviews.average(:rating).round(2)
    end
  end

  # GET /plays/new
  def new
    @play = current_user.plays.build
    @categories = Category.all.map { |c| [c.name, c.id]}
  end

  # POST /plays
  # POST /plays.json
  def create
    @play = current_user.plays.build(play_params)
    respond_to do |format|
      if @play.save
        format.html { redirect_to @play, notice: 'Play was successfully created.' }
        format.json { render :show, status: :created, location: @play }
      else 
        @categories = Category.all.map { |c| [c.name, c.id]}
        format.html { render :new }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /plays/1/edit
  def edit
    @categories = Category.all.map { |c| [c.name, c.id]}
  end

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to @play, notice: 'Play was successfully updated.' }
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.json
  def destroy
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url, notice: 'Play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params.require(:play).permit(:title, :description, :director, :category_id, :play_img)
    end
end
