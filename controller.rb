# controller.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright Haris Amin. All rights reserved.

require 'core_data'

class Controller
  include CoreData
  
  attr_accessor :testString, :regex, :bwLabel, :matchedString, :window
	attr_accessor :referenceTableView

  def evalRegex(sender)
		begin
		  text = @testString.stringValue
		  regex = Regexp.new(@regex.stringValue)
		  outText = text.scan(regex).join
			@matchedString.stringValue = outText
		rescue RegexpError
			@matchedString.stringValue = 'No Match'
			@matchedString.textColor = redColort
		end		
  end
	
	
  def awakeFromNib
    @ref_data = [] # [ value, description, selection range ]
    @ref_data << [ '[abc]', 'A single character: a, b or c', { :skip => 1, :include => 3} ] 
    @ref_data << [ '.', 'Any single character', nil ]
    @ref_data << [ '(...)', 'Capture everything enclosed', {:skip => 1, :include => 3} ]
    @ref_data << [ '[^abc]', 'Any single character but: a, b or c', {:skip => 2, :include => 3} ]
    @ref_data << [ '\s', 'Any whitespace character', nil ]
    @ref_data << [ '(a|b)', 'a or b', {:skip => 1, :include => 3} ]
    @ref_data << [ '[a-z]', 'Any single character in the range a-z', {:skip => 1, :include => 3} ]
    @ref_data << [ '\S', 'Any non-whitespace character', nil ]
    @ref_data << [ 'a?', 'Zero or one of a', {:skip => 0, :include => 1} ]
    @ref_data << [ '[a-zA-Z]', 'Any single character in the range a-z of A-Z', {:skip => 1, :include => 6} ]
    @ref_data << [ '\d', 'Any digit', nil ]
    @ref_data << [ 'a*', 'Zero or more of a', {:skip => 0, :include => 1} ]
    @ref_data << [ '[^]', 'Start of line', nil ] ### MAYBE???
    @ref_data << [ '\D', 'Any non-digit', nil ]
    @ref_data << [ 'a+', 'One or more of a', {:skip => 0, :include => 1} ]
    @ref_data << [ '[$]', 'End of line', nil ] ### MAYBE???
    @ref_data << [ '\w', 'Any word character (letter, number, underscore)', nil ]
    @ref_data << [ 'a{3}', 'Exactly 3 of a', {:skip => 0, :include => 1} ]
    @ref_data << [ '[\A]', 'Start of string', nil ] ### MAYBE???
    @ref_data << [ '\W', 'Any non-word character', nil ]
    @ref_data << [ 'a{3,}', '3 or more of a', {:skip => 0, :include => 1} ]
    @ref_data << [ '[\z]', 'End of string', nil ] ### MAYBE???
    @ref_data << [ '\b', 'Any word boundary character', nil ]
    @ref_data << [ 'a{3,6}', 'Between 3 and 6 of a', {:skip => 0, :include => 1} ]

		@referenceTableView.dataSource = self
    
    seed_data
  end
  
  def seed_data
    snippet = NSEntityDescription.insertNewObjectForEntityForName("Snippet", inManagedObjectContext:@managedObjectContext)
    
    snippet.title = "Email Regex"
    snippet.regexp = "\d..(a^)"
    snippet.created_at = NSDate.date
    snippet.updated_at = NSDate.date
    snippet.summary = "This is an email regexp"
    snippet.test_string = "Haris Amin's eamil address is aminharis7@gmail.com"
    
    @managedObjectContext.save(nil)
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
  
  def tableViewSelectionDidChange(notification)
    selected_row = @referenceTableView.selectedRow
    selected_regex = @ref_data[selected_row][0]
    old_regex = @regex.stringValue
    new_regex = old_regex + selected_regex
    @regex.stringValue = new_regex
    range_info = @ref_data[selected_row][2]

    unless range_info.nil?
      @regex.selectText self
      range = NSMakeRange( old_regex.length + range_info[:skip], range_info[:include] )
      @regex.currentEditor.setSelectedRange range
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