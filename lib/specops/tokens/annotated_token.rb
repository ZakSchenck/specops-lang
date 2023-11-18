require_relative "token"
module Specops
    module Tokens
        class AnnotatedToken < Token
            attr_reader :annotation
            def initialize(lexeme, offset, annotation)
                super(lexeme, offset)
                @annotation = annotation
            end
        end
    end
end