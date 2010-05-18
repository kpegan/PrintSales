require 'digest/sha1'

class User < ActiveRecord::Base
  belongs_to :department
  belongs_to :role
  has_many :jobs
  
  delegate :permissions, :to => :role
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  #Stuff I added
  validates_presence_of :mica_id
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :position
  validates_presence_of :graduation, :if => :student?
  
  validates_format_of :phone,
    :with => /\d{10,10}/i,
    :message => "Please provide a phone number with area code."
  validates_uniqueness_of :mica_id
 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :mica_id, :login, :email, :first_name, :last_name, 
    :phone, :department_id,:position,:role_id, :password, :password_confirmation, :graduation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  #PrintSales specific methods
  def full_name 
    if first_name.nil? or last_name.nil?
      " "
    else
      first_name + " " + last_name
    end
  end
  
  def student?
    position == "student"
  end
  
  def phone_formatted
    "(" + phone[0..2] + ") " + phone[3..5] + "-" + phone[6..9]
  end
  
  def grad_date 
    if graduation.nil? 
      "N/A"
    else
      graduation
    end
  end
  
  
  #Added for admin characteristics
  
  def method_missing(method_id, *args)
    if match = matches_dynamic_role_check?(method_id)
      tokenize_roles(match.captures.first).each do |check|
        return true if role.name.downcase == check
      end
      return false
    else
      super
    end
  end
 
  private
 
  def matches_dynamic_role_check?(method_id)
    /^is_an?_([a-zA-Z]\w*)\?$/.match(method_id.to_s)
  end
 
  def tokenize_roles(string_to_split)
    string_to_split.split(/_or_/)
  end
    


end
