class App
    def initialize
      @all_things = []
    end
  
    def create_book
      print 'Date of publishing: '
      date = gets.chomp
  
      book = Book.new(date)
      @all_things << book
      puts 'Item Created Successfully'
    end

    #you can add your required def here
  end