class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  after_create :make_wallet
  # Include default devise modules. Others availale are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :token_authenticatable

  attr_accessor :login

  has_many :games, through: :game_sessions
  has_many :wallets
  has_many :game_sessions

  validates_presence_of :username
  validates_uniqueness_of :username

  def unfinished_games
    games.where('state != ?', 'finished')
  end

  def won
    games.where(winner: 'player').count
  end

  def lost
    games.where(winner: 'dealer').count
  end

  def tied
    games.where(winner: 'tie').count
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private
  
  def make_wallet
    Wallet.create!(balance: 500, user_id: id)
  end
end
