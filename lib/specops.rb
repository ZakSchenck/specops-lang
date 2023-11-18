# frozen_string_literal: true

require_relative "specops/version"
require_relative "specops/scanner"

module Specops
  class Error < StandardError; end
  
  def self.main
    $stdin.each_line do |line|
      puts "the line is: #{line}"
      scanner = Scanner.new(line.chomp)
      tokens = scanner.scan
      puts tokens
    end 
  end
end

