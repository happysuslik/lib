class Reader

attr_reader :name, :email, :city, :street, :house

  def initialize(options={})
    @name = options [:name]
    @email = options [:email]
    @city = options [:city]
    @street = options [:street]
    @house = options [:house]
   end
end