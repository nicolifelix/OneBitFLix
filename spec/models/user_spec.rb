# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validade do usuário' do
    it 'Teste 1 - Usuário válido?' do
      user = User.new
      user.name = 'Nicoli'
      user.email = 'nicoli@gmail.com'

      expect(user.valid?).to be_truthy
    end

    # sistema não deve aceitar usuário sem o e-mail
    it 'Teste 2 - Usuário inválido?' do
      user = User.new
      user.name = 'Nicoli'
      user.email = nil

      expect(user.valid?).to be_falsey
    end
  end

  # deve pedir nome e sobrenome
  context 'Títulos válidos' do
    it 'Teste 3 - Título completo' do
      user = User.new
      user.name = 'Nicoli Félix'
      user.email = 'nicoli@gmail.com'

      expect(user.titulo_completo).to eql('Nicoli Félix - Email: nicoli@gmail.com')
    end
  end
end
