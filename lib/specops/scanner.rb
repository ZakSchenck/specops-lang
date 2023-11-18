require_relative "./tokens/multiply"
require_relative "./tokens/subtract"
require_relative "./tokens/plus"
require_relative "./tokens/divide"

module Specops
  class Scanner
    def initialize(stream)
      @stream = stream
      @stream_pointer = 0
      @token_start = 0
      @tokens = []
    end

    def scan
      until eof?
        @token_start = @stream_pointer
        c = advance
        case c
        when "+"
          @tokens << Tokens::Plus.new(@stream[@token_start...@stream_pointer], @token_start)
        when "-"
          @tokens << Tokens::Subtract.new(@stream[@token_start...@stream_pointer], @token_start)
        when "*"
          @tokens << Tokens::Multiply.new(@stream[@token_start...@stream_pointer], @token_start)
        when "/"
          @tokens << Tokens::Divide.new(@stream[@token_start...@stream_pointer], @token_start)
        when /[0-9]/
          @tokens << scan_number
        end
      end

      @tokens
    end

    private

    def eof?
      @stream_pointer >= @stream.size
    end

    def advance
      @stream[@stream_pointer].tap { @stream_pointer += 1 }
    end

    def peek
        @stream[@stream_pointer + 1]
    end

    def scan_number
        while /[0-9]/.match?(peek)
            advance
        end

        if peek == '.'
            advance
            while /[0-9]/.match?(peek)
                advance
            end
        end

        lexeme = @stream[@token_start...@stream_pointer]
        n = if lexeme.include?(".")
            lexeme.to_f
          else
            lexeme.to_i
          end
        Tokens::Number.new(lexeme, @token_start, n)
    end
  end
end
