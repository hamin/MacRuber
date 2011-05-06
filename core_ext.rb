# core_ext.rb
# MacRuber
#
# Created by Haris Amin on 4/29/11.
# Copyright 2011 Haris Amin. All rights reserved.

class NSTextView
  def appendText(string)
    self.selectAll(nil)
    wholeRange = self.selectedRange
    endRange = NSMakeRange(wholeRange.length, 0)
    self.setSelectedRange(endRange)
    self.insertText(string)
  end
	
	def clear
	  self.setString('')
	end
end