# controller.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright Haris Amin. All rights reserved.

class Controller
  attr_accessor :testString, :regex, :bwLabel,:window, :outputLabel,:t1,:t2

  def evalRegex(sender)
		text = @testString.stringValue
		regex = Regexp.new(@regex.stringValue)
		outText = text.scan(regex).join
		@bwLabel.stringValue = outText
  end
	
	def clearAllTextViews(sender)
		[@testString,@regex,@bwLabel].each{|e| e.stringValue=''}
	end

  def applicationDidFinishLaunching(note)
    font = NSFont.fontWithName("Menlo-Regular", size: 13)
    @inTextField.setFont(font)
    @outTextField.setFont(font)
  end

  def applicationShouldTerminateAfterLastWindowClosed(application)
    true
  end
end



