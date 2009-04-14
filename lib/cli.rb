module CLI
  def warn(message)
    wrap(STDERR){ STDERR.puts "Warning: #{message}" }
  end

  def error(message)
    wrap(STDERR){ STDERR.puts "Error: #{message}" }
    exit 1
  end
  
  def stars(num=50)
    return "*" * num
  end
  
  def wrap(stream=STDOUT)
    stream.puts stars
    yield
    stream.puts stars
  end

  def ask(question, default=nil, valid_response=nil, invalid_message=nil)
    loop do
      print "#{question}"
      print " [#{default}]" if default
      print ": "
      answer = STDIN.gets.chomp
      answer = default if default && answer.empty?
      valid = false
      valid = true if valid_response.nil?
      valid = true if valid_response.respond_to?(:include?) && valid_response.include?(answer)
      valid = true if valid_response.respond_to?(:match) && valid_response.match(answer)
      if valid
        return answer
      else
        if valid_response.is_a?(Array)
          puts invalid_message || begin
            print "Invalid answer, please try again."
            print " Valid answers include:\n"
            puts valid_response
          end
        elsif valid_response.is_a?(Regexp)
          puts invalid_message || "Invalid format for answer, please try again."
        else
          puts invalid_message || "Invalid answer, please try again."
        end
      end
    end  
  end
end