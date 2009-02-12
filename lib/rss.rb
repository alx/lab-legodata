# bookmark.rb
require 'open-uri'
require 'hpricot'
  
module RssHelper
  
  # call-seq:
  # Create list of links from options[:source]
  #
  def rss_list(options = {})
    
    rss = Hpricot(open(options[:source]))
    
    out = "<ul class=\"bookmark\">\n"
    rss.search("source").each do |source|
      break if source.nil?
      out << "<li><a href='#{source[:url]}'>#{truncate_words(source.inner_html)}</a></li>"
    end
    out << "\n</ul>\n"
    
    # put some guards around the output (specifically for textile)
    out = _guard(out)
  end
  
  def truncate_words(text, length = 30, end_string = ' …')
    return if text == nil
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
  
end  # module RssHelper

Webby::Helpers.register(RssHelper)