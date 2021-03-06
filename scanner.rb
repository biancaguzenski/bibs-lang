require "#{File.dirname(__FILE__)}/token"

VALID_INTEGERS = /^\d+/
VALID_OPERATORS = /^\+|^\-/

class Scanner
    def initialize
        @pointer = 0
    end

    def tokenizer(values)
        tokens = []
        values = values.gsub(" ", "")
        while !values.empty?
            if is_valid_integer?(values)
                integer_tokens = values.scan(VALID_INTEGERS)
                tokens << Token.new("integer", integer_tokens.first.to_i)
                @pointer += integer_tokens.first.size
                values = values.sub(VALID_INTEGERS, "")
            elsif is_valid_operator?(values)
                operator_tokens = values.scan(VALID_OPERATORS)
                tokens << Token.new("operator", operator_tokens.first)
                @pointer += 1
                values = values.sub(VALID_OPERATORS, "")
            else
                raise "Unexpected value found at the #{@pointer} column!"
            end
        end
        return tokens
    end

    private
    
    def is_valid_integer?(values)
        values.match(VALID_INTEGERS)
    end

    def is_valid_operator?(values)
        values.match(VALID_OPERATORS)
    end

    def is_valid_operator_use?(values, pointer)
        VALID_OPERATORS.include?(values[pointer])
    end
end