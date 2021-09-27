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
  end
end
