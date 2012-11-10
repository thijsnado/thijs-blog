# from http://railscasts.com/episodes/207-syntax-highlighting-revised?view=asciicast
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  rescue
    Pygments.highlight(code)
  end
end
