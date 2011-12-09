#
#  snippets_controller.rb
#  MacRuber
#
#  Created by Haris Amin on 12/9/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'core_data'
class SnippetsController
  include CoreData
  attr_accessor :regex, :testString
  attr_accessor :snippets
  
  
  def tableViewSelectionDidChange(notification)
    NSLog "IT SNIPPET CAME HERE!!!!"
    
    # Fill in Snippet info
    if snippet_object = @snippets.selectedObjects.first
      @regex.stringValue = snippet_object.regexp
      @testString.stringValue = snippet_object.test_string
    end  
  end 
  
end

