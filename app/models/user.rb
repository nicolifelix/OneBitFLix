# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :trackable,
         :validatable
  has_many :reviews
  has_many :favorites
  has_many :players
  validates :name, presence: true, on: :update
  validates :email, presence: true



# TESTE: Esse método pede que usuário digite o nome completo ao realizar o login
# @param String
# @return 
  def titulo_completo
    "#{name} - Email: #{email}"
  end
end
