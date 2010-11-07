module SrpmHelper
  def simple_changelog(text, html_options={}, options={})                                                                                                                      
    text = ''.html_safe if text.nil?                                                                                                                                        
    start_tag = tag('<li>', html_options, true)                                                                                                                                
    text = sanitize(text) unless options[:sanitize] == false                                                                                                                
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n                                                                                                        
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1</li><li>') # 1 newline   -> </li><li>                                                                                                        
    text.insert 0, start_tag                                                                                                                                                
    text.html_safe.safe_concat("</li>")                                                                                                                                      
  end
end