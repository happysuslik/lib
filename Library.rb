require 'yaml'
require_relative 'Book.rb'
require_relative 'Order.rb'
require_relative 'Reader.rb'
require_relative 'Author.rb'

class Library
  
attr_accessor :books, :orders, :readers, :authors

  def initialize
    @books = []
    @orders = []
    @readers = []
    @authors = []
  end

  def add_book(book)
    @books.push book
  end

  def add_order(order)
    @orders.push order
  end

  def add_reader(reader)
     @readers.push reader
  end

  def add_author(author)
    @authors.push author
  end

  def save(file)
    File.open(file, "w") { |file| file.puts(self.to_yaml) }
  end

  # Ищем популярную книгу.
  def popular
    book_pop = Hash.new(0)
    book_title = @orders.map  {  |ord|  ord.book.title  } 
    book_title.each { |title| book_pop[title] += 1 } 
    book_max = book_pop.max_by { |_key, value| value } 
    p "#{ book_max.first }"
  end

  # Смотрим кто брал книгу большое кол-во раз.
  def often(book)
    order_reader = Hash.new(0)
    @orders.select { |order| order.book == book }.each { |order| order_reader[order.reader] += 1 }
    order_max = order_reader.max_by { |_key, value| value }
    p "#{ order_max.first.name }"
  end

  # Сколько человек заказали одну из трех самых популярных книг.
  def ordered(pop)
    order_reader = Hash.new(0)
    @orders.select { |ord| ord.book.title ==pop }.each { |order| order_reader[order.reader] += 1 }  
    order_max = order_reader.max_by { |_key, value| value }
    order_min = order_reader.min_by { |_key, value| value <= order_max[1] }
    p "#{ order_max.first.name }"  +  " и " + "#{ order_min.first.name }"
  end


  def load(file)
     read_lib  = File.open(file, "r")  do  |file|
       read_lib = YAML.load(file)
     end
     p read_lib
  end
end

  library = Library.new

  author1 = Author.new( :name => "Роберт", :biography => "псп")
  author2 = Author.new( :name => "Марк", :biography => "профессор")
  author3 = Author.new( :name => "Карлос", :biography => "мистик")

  book1 = Book.new( :title => "Психология влияния", :author => author1)
  book2 = Book.new( :title => "Ментальные ловушки на работе", :author => author2)
  book3 = Book.new( :title => "Сила безмолвия", :author => author3)
  book4 = Book.new( :title => "Лампа", :author => author2)
  book5 = Book.new( :title => "Дрын", :author => author3)
  book6 = Book.new( :title => "Карусель", :author => author1)

  reader1 = Reader.new( :name => "Петрович",
                        :email => "p@i.ua",
                        :city => "Днепр",
                        :street => "Метро",
                        :house => "5")
  reader2 = Reader.new( :name => "Михалыч",
                        :email => "m@i.ua",
                        :city => "Днепр",
                        :street => "Подвал",
                        :house => "10")
  reader3 = Reader.new( :name => "Кузьмич",
                        :email => "s@i.ua",
                        :city => "Одесса",
                        :street => "Деребасовская",
                        :house => "2")
  reader4 = Reader.new( :name => "Хотабыч",
                        :email => "h@i.ua",
                        :city => "Арман",
                        :street => "Хазгы",
                        :house => "3")

  order1 = Order.new( :book => book2,
                      :reader => reader1,
                      :date => Time.now)
  order2 = Order.new( :book => book1,
                      :reader => reader2,
                      :date => Time.now)
  order3 = Order.new( :book => book2,
                      :reader => reader4,
                      :date => Time.now)
  order4 = Order.new( :book => book3,
                      :reader => reader4,
                      :date => Time.now)
  order5 = Order.new( :book => book6,
                      :reader => reader1,
                      :date => Time.now)
  order6 = Order.new( :book => book5,
                      :reader => reader2,
                      :date => Time.now)
  order7 = Order.new( :book => book5,
                      :reader => reader1,
                      :date => Time.now)
  order8 = Order.new( :book => book1,
                      :reader => reader2,
                      :date => Time.now)
  order9 = Order.new( :book => book2,
                      :reader => reader4,
                      :date => Time.now)
  order10 = Order.new( :book => book5,
                       :reader => reader3,
                       :date => Time.now)
  order11 = Order.new( :book => book1,
                       :reader => reader1,
                       :date => Time.now)

  library.add_book(book1)
  library.add_book(book2)
  library.add_book(book3)
  library.add_book(book4)
  library.add_book(book5)
  library.add_book(book6)

  library.add_order(order1)
  library.add_order(order2)
  library.add_order(order3)
  library.add_order(order4)
  library.add_order(order5)
  library.add_order(order6)
  library.add_order(order7)
  library.add_order(order8)
  library.add_order(order9)
  library.add_order(order10)
  library.add_order(order11)

  library.add_reader(reader1)
  library.add_reader(reader2)
  library.add_reader(reader3)
  library.add_reader(reader4)

  library.add_author(author1)
  library.add_author(author2)
  library.add_author(author3)


  @pop = library.popular
  library.often(book1)
  library.ordered(@pop)
  library.save("Library.yaml")
  library.load("Library.yaml")