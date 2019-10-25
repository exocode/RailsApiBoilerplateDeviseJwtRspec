class User
  include Mongoid::Document
  include Devise::JWT::RevocationStrategies::JTIMatcher

  extend Enumerize

  # Include default devise modules. Others available are:
  #  :lockable, and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :trackable,
         :timeoutable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  ## Database authenticatable
  field :email, type: String, default: ''
  field :encrypted_password, type: String, default: ''
  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  ## Rememberable
  # field :remember_created_at, type: Time
  ## Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String
  ## Confirmable
  field :confirmation_token, type: String
  field :confirmed_at, type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email, type: String # Only if using reconfirmable
  ## Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token, type: String # Only if unlock strategy is :email or :both
  field :locked_at, type: Time

  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :birthday, type: Date
  field :city, type: String
  field :country, type: String
  field :roles, type: Array

  # JWT ID
  field :jti, type: String
  field :remember_created_at, type: DateTime

  # - VALIDATIONS
  validates_uniqueness_of :email, :jti
  validates :email, presence: true
  validates :email, length: {maximum: 255}
  validates :email, format: {with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i}
  validates :first_name, length: {maximum: 255}
  validates :last_name, length: {maximum: 255}
  validates :username, length: {minimunm: 6, maximum: 255}

  index({ jti: 1 }, { unique: true, name: "jti_index" })

  # add new roles to the end
  enumerize :role, in: %i[visitor customer admin], default: :visitor

  # - CALLBACKS
  after_initialize :setup_new_user, if: :new_record?

  # Send mail through activejob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self.to_json, *args).deliver_later
  end

  def jwt_payload
    super.merge('uid' => id.to_s)
  end

  def self.primary_key
    '_id'
  end

  def self.revoke_jwt(_payload, user)
    user.update_attribute(:jti, generate_jti)
  end

  def admin?
    roles.include? :admin
  end

  private

  def setup_new_user
    self.role ||= :customer
  end
end
