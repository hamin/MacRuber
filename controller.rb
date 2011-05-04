# controller.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright Haris Amin. All rights reserved.

class Controller
  attr_accessor :testString, :regex, :bwLabel,:window, :outputLabel

  def evalRegex(sender)
		text = @testString.textStorage.mutableString
		regex = Regexp.new(@regex.textStorage.mutableString)
		outText = text.scan(regex).join
		@bwLabel.stringValue = outText
  end
	
	def clearAllTextViews(sender)
	  @testString.clear
		@regex.clear
		@bwLabel.stringValue = ''
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



