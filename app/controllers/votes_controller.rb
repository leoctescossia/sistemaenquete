class VotesController < ApplicationController
  before_action :require_user

  def admin_signed_in?
    user_signed_in? && current_user.role === "admin"
  end

  def index
    @votes = Vote.all
  end

  def create
    puts "DEBUG: Parâmetros recebidos: #{params.inspect}"
    puts "DEBUG: Usuário atual: #{current_user.inspect}"

    if params[:option_id] # Votação única
      option = Option.find(params[:option_id])
      vote = option.votes.new(user: current_user)
      puts "DEBUG: Opção encontrada: #{option.inspect}"
      puts "DEBUG: Voto a ser criado: #{vote.inspect}"

      if vote.save
        puts "DEBUG: Voto salvo com sucesso!"
        redirect_to option.poll, notice: "Voto registrado com sucesso!"
      else
        puts "DEBUG: Erros ao salvar voto: #{vote.errors.full_messages}"
        redirect_to option.poll, alert: vote.errors.full_messages.to_sentence
      end

    elsif params[:option_ids] # Votação múltipla
      poll = Poll.find(params[:poll_id])
      success = true
      errors = []

      if poll.votes.where(user: current_user).exists?
        redirect_to poll, alert: "Você já votou nesta enquete."
        return
      end

      params[:option_ids].each do |option_id|
        option = Option.find(option_id)
        vote = option.votes.new(user: current_user)

        unless vote.save
          success = false
          errors << vote.errors.full_messages.to_sentence
        end
      end

      if success
        redirect_to poll, notice: "Votos registrados com sucesso!"
      else
        redirect_to poll, alert: errors.join(", ")
      end
    else
      redirect_to polls_path, alert: "Selecione pelo menos uma opção para votar."
    end

    
  end

  private

  def require_user
    redirect_to root_path, alert: "Acesso negado." unless current_user&.user?
  end
end
