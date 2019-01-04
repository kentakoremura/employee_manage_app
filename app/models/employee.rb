class Employee < ApplicationRecord
  has_secure_password
  has_many :responsibles, dependent: :destroy
  has_many :stores, through: :responsibles
  accepts_nested_attributes_for :responsibles
  validates_associated :responsibles

  validates :name, {presence: true, length: { maximum: 30 }}
  validates :email, {presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }}
  validates :password, {presence: true, length: { minimum: 6 }}
  validates :sex, {presence: true, inclusion:{in: ["M", "F"]}}
  #validates :birthday, {format: { with: /\A\d{4}(\-|\/)\d{2}(\-|\/)\d{2}\z/ }}, if: "birthday.nil?"
  #validates :joinday, {format: { with: /\A\d{4}(\-|\/)\d{2}(\-|\/)\d{2}\z/ }}, if: "joinday.nil?"
  validates_date :birthday, :on_or_before => lambda { Date.current }, if: Proc.new { |a| a.birthday.present? }
  validates_date :joinday, :on_or_before => lambda { Date.current }, if: Proc.new { |a| a.joinday.present? }

  def self.ransackable_attributes(auth_object = nil)
    %w[name email sex birthday joinday responsibles_store_id]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def age
    unless self.birthday
      return
    end
    date_format = "%Y%m%d"
    age = (Date.today.strftime(date_format).to_i - self.birthday.strftime(date_format).to_i) / 10000
    return age
  end

  def working
    unless self.joinday
      return
    end
    date_format = "%Y%m%d"
    working = (Date.today.strftime(date_format).to_i - self.joinday.strftime(date_format).to_i) / 10000
    return working
  end

  def sex_display
    case self.sex
    when "M" then
      return I18n.t("activerecord.attributes.employee.sex_male")
    when "F" then
      return I18n.t("activerecord.attributes.employee.sex_female")
    end
  end
end
