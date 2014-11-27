class Book

attr_reader  :title, :author 

  def initialize (options={})
    @title = options [:title]
    @author = options [:author]
  end 
end