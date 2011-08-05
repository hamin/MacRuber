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
		@referenceTableView.dataSource = self
  end
	
	def numberOfRowsInTableView(view)
    2
  end
	
  def tableView(view, objectValueForTableColumn:column, row:index)
	  "foo"
		puts column.inspect
		NSLog "data: #{column}"
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