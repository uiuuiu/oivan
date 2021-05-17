module Sinatra
  module HTMLEscapeHelper
    def h(text)
      Rack::Utils.escape_html(text)
    end

    def escape_html(text)
      ERB::Util.html_escape(text)
    end

    def convert_to_html(text)
      text.gsub(/\n/, "<br/>")
    end
  end

  helpers HTMLEscapeHelper
end