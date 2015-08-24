class String
  def strip_heredoc!
    indent = scan(/(?<=\n)[ ]*(?=\S)/).min

    gsub!(/\n[ ]{#{indent.length}}/, "\n") if indent
  end
end
