class Car < ActiveRecord:: Base
  after_initialize :default_status
  before_save :capital
  before_validation :down
  validates_format_of :location,:mod,:manf, :with => /^[A-Za-z0-9 ]*$/, :multiline => true, :message => "Please provide a valid input"
  validates :style, :inclusion  => { :in => ['suv','coupe','sedan'],
                                     :message => "It is not a valid Style, Please mention Suv or Sedan or Coupe"}
  validates_numericality_of :rate, :on => :create, :message => "Please provide a valid Hourly Rental Rate"

  private
  def down
     self.style= self.style.downcase
  end
  def capital
    self.manf=self.manf.capitalize
    self.mod=self.mod.capitalize
    self.location=self.location.capitalize
    self.style=self.style.capitalize
  end
  def default_status
    self.status ||= "Available"
  end
end
