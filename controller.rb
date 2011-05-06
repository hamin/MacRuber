# controller.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright Haris Amin. All rights reserved.

class Controller
  attr_accessor :testString, :regex, :bwLabel,:window

  def evalRegex(sender)
		begin
		  text = @testString.stringValue
		  regex = Regexp.new(@regex.stringValue)
		  outText = text.scan(regex).join
		  @bwLabel.stringValue = outText
		rescue RegexpError
		  @bwLabel.stringValue = 'No Match'
			@bwLabel.textColor = redColor
			
		end		
  end
	
	def controlTextDidChange(notification)
		evalRegex(self)
	end
		
	def clearAllTextViews(sender)
		[@testString,@regex,@bwLabel].each{|e| e.stringValue=''}
	end

  def applicationDidFinishLaunching(note)
  end

  def applicationShouldTerminateAfterLastWindowClosed(application)
    true
  end
end