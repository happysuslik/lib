class Author

attr_reader :name, :biography

  def initialize(options={})
    @name = options [:name]
    @biography = options [:biography]
  end
end