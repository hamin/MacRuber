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
    @ref_data = []
    @ref_data << [ '[abc]', 'A single character: a, b or c' ] 
    @ref_data << [ '.', 'Any single character' ]
    @ref_data << [ '(...)', 'Capture everything enclosed' ]
    @ref_data << [ '[^abc]', 'Any single character but: a, b or c', '\s' ]
    @ref_data << [ '\s', 'Any whitespace character' ]
    @ref_data << [ '(a|b)', 'a or b' ]
    @ref_data << [ '[a-z]', 'Any single character in the range a-z' ]
    @ref_data << [ '\S', 'Any non-whitespace character' ]
    @ref_data << [ 'a?', 'Zero or one of a' ]
    @ref_data << [ '[a-zA-Z]', 'Any single character in the range a-z of A-Z' ]
    @ref_data << [ '\d', 'Any digit' ]
    @ref_data << [ 'a*', 'Zero or more of a' ]
    @ref_data << [ '[^]', 'Start of line' ]
    @ref_data << [ '\D', 'Any non-digit' ]
    @ref_data << [ 'a+', 'One or more of a' ]
    @ref_data << [ '[$]', 'End of line' ]
    @ref_data << [ '\w', 'Any word character (letter, number, underscore)' ]
    @ref_data << [ 'a{3}', 'Exactly 3 of a' ]
    @ref_data << [ '[\A]', 'Start of string' ]
    @ref_data << [ '\W', 'Any non-word character' ]
    @ref_data << [ 'a{3,}', '3 or more of a' ]
    @ref_data << [ '[\z]', 'End of string' ]
    @ref_data << [ '\b', 'Any word boundary character' ]
    @ref_data << [ 'a{3,6}', 'Between 3 and 6 of a' ]

		@referenceTableView.dataSource = self
  end
	
	def numberOfRowsInTableView(view)
    @ref_data.size
  end
	
  def tableView(view, objectValueForTableColumn:column, row:index)
    row_data = @ref_data[index]
    
    case column.identifier
    when "col0"
      row_data[0]
    when "col1"
      row_data[1]
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