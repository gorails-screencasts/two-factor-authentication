class User < ApplicationRecord
  devise :two_factor_authenticatable, :two_factor_backupable, :otp_secret_encryption_key => Rails.application.secrets.otp_key

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  def otp_qr_code
    issuer = 'GoRails'
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label, issuer: issuer))
    qrcode.as_svg(module_size: 4)
  end
end
