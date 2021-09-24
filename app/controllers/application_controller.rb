class ApplicationController < ActionController::Base
   # autenticação em todos os controllers do APP atualizando o controller principal
  before_action :authenticate_user!
end