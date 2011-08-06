# controller.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright Haris Amin. All rights reserved.

class Controller
  attr_accessor :testString, :regex, :bwLabel, :matchedString, :window
	attr_writer :referenceTableView

  def evalRegex(sender)
		begin
		  text = @testString.stringValue
		  regex = Regexp.new(@regex.stringValue)
		  outText = text.scan(regex).join
			@matchedString.stringValue = outText
		rescue RegexpError
			@matchedString.stringValue = 'No Match'
			@matchedString.textColor = redColor
		end		
  end
	
	
  def awakeFromNib
    @data = []
    @data << [ '[abc]', 'A single character: a, b or c', '.', 'Any single character', '(...)', 'Capture everything enclosed' ]
    @data << [ '[^abc]', 'Any single character but: a, b or c', '\s', 'Any whitespace character', '(a|b)', 'a or b' ]
    @data << [ '[a-z]', 'Any single character in the range a-z', '\S', 'Any non-whitespace character', 'a?', 'Zero or one of a' ]
    @data << [ '[a-zA-Z]', 'Any single character in the range a-z of A-Z', '\d', 'Any digit', 'a*', 'Zero or more of a' ]
    @data << [ '[^]', 'Start of line', '\D', 'Any non-digit', 'a+', 'One or more of a' ]
    @data << [ '[$]', 'End of line', '\w', 'Any word character (letter, number, underscore)', 'a{3}', 'Exactly 3 of a' ]
    @data << [ '[\A]', 'Start of string', '\W', 'Any non-word character', 'a{3,}', '3 or more of a' ]
    @data << [ '[\z]', 'End of string', '\b', 'Any word boundary character', 'a{3,6}', 'Between 3 and 6 of a' ]
		@referenceTableView.dataSource = self
  end
	
	def numberOfRowsInTableView(view)
    # @data.size
    8
  end
  
  # def numberOfColumnsInTableView(view)
  #   6
  # end
	
  def tableView(view, objectValueForTableColumn:column, row:index)
    row_data = @data[index]
    
    case column.identifier
    when "col0"
      row_data[0]
    when "col1"
      row_data[1]
    when "col2"
      row_data[2]
    when "col3"
      row_data[3]
    when "col4"
      row_data[4]
    when "col5"
      row_data[5]         
    end
    
  end
	
	def controlTextDidChange(notification)
		evalRegex(self)
	end
		
	def clearAllTextViews(sender)
		[@testString,@regex,@matchedString].each{|e| e.stringValue=''}
	end

  def applicationDidFinishLaunching(note)
  end

  def applicationShouldTerminateAfterLastWindowClosed(application)
    true
  end
end