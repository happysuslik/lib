class Order

attr_accessor :book, :reader, :date

  def initialize(options={})
    @book = options [:book]
    @reader = options [:reader]
    @date = options [:date]
  end
end