module Specops
    module Tokens
        class Token
            def initialize(lexeme, offset)
                @lexeme = lexeme
                @offset = offset
            end
        end
    end
end