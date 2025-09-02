class PollsController < ApplicationController
  # está logado
  before_action :require_user
  before_action :set_poll, only: %i[ show edit update destroy close ]
  before_action :authenticate_user!, except: [:index, :show]

  helper_method :admin_signed_in?

  def admin_signed_in?
    user_signed_in? && current_user.role === "admin"
  end


  # GET /polls or /polls.json
  def index
    # @polls = Poll.all
    per_page = 5 # quantos registros por página
    page = params[:page].to_i
    page = 1 if page < 1

    polls_scope = Poll.all

    if params[:status].present?
      polls_scope = polls_scope.where(status: params[:status])
    end

    @total_polls = polls_scope.count
    @total_pages = (@total_polls.to_f / per_page).ceil
    @current_page = page

    @polls = polls_scope.offset((page - 1) * per_page).limit(per_page)
  end

  # GET /polls/1 or /polls/1.json
  def show
  end

  def my_polls
    unless !admin_signed_in?
      redirect_to root_path, alert: "Acesso negado, apenas usuários podem visualizar as próprias Enquetes."
      return
    end
    # @polls = current_user.polls.order(created_at: :desc)
    current_user_poll_array = current_user.polls
    per_page = 5 # quantos registros por página
    page = params[:page].to_i
    page = 1 if page < 1

    @polls = current_user_poll_array.offset((page - 1) * per_page).limit(per_page)
    @total_polls = current_user_poll_array.count
    @per_page = per_page
    @current_page = page
    @total_pages = (@total_polls.to_f / per_page).ceil
  end

  def meus_votos
    if !admin_signed_in?
      @polls = Poll.joins(options: :votes)
                  .where(votes: { user_id: current_user.id })
                  .distinct
    else
      redirect_to polls_path, alert: "Admins não possuem votos registrados."
    end
  end


  # GET /polls/new
  def new
    unless !admin_signed_in?
      redirect_to polls_path, alert: "Acesso negado, apenas usuários podem cadastrar Enquetes."
      return
    end

    @poll = Poll.new
    # @users_not_admin = User.where.not(role: 1) # Verificar para mostrar todos o usuários que não são admin no select
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls or /polls.json
  def create
    # Verificar se é admin ou usuário
    unless user_signed_in?
      redirect_to polls_path, alert: "Acesso negado, apenas usuários podem cadastrar Enquetes."
      return
    end

    # @poll = Poll.new(poll_params)
    @poll = current_user.polls.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: "A enquete foi criada com sucesso." }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1 or /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: "A enquete foi editada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1 or /polls/1.json
  def destroy
    @poll.destroy!

    respond_to do |format|
      format.html { redirect_to polls_path, notice: "A enquete foi excluída com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def close
    @poll.close!
    redirect_to @poll, notice: "Enquete encerrada com sucesso."
  end

  def require_user
    redirect_to root_path, alert: "Acesso negado." unless current_user&.user?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      # params.require(:poll).permit(:title, :description, :poll_type, :status, :user_id, options_attributes: [:id, :text, :_destroy])
      params.require(:poll).permit(:title, :description, :poll_type, :status, options_attributes: [:id, :text, :_destroy])
    end
end
