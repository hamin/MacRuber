# controller.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright Haris Amin. All rights reserved.

class Controller
  attr_accessor :testString, :regex, :result,:window

  def evalRegex(sender)
		text = @testString.textStorage.mutableString
		regex = @regex.textStorage.mutableString
		outText = text.match(regex).to_s
		@result.clear
		@result.appendText(outText)
  end
	
	def clearAllTextViews(sender)
	  @testString.clear
		@regex.clear
		@result.clear
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



