# 代码生成时间: 2025-08-22 15:59:33
# MathUtilityTool.rb
# A simple math utility tool set using Ruby.

require 'cuba'

# Define the MathUtilityTool class which will handle the math operations.
class MathUtilityTool
  # Calculate the sum of two numbers.
  #
  # @param num1 [Float] The first number.
  # @param num2 [Float] The second number.
  # @return [Float] The sum of the two numbers.
  def self.add(num1, num2)
    num1 + num2
  end

  # Calculate the difference between two numbers.
  #
  # @param num1 [Float] The first number.
  # @param num2 [Float] The second number.
  # @return [Float] The difference between the two numbers.
  def self.subtract(num1, num2)
    num1 - num2
  end

  # Calculate the product of two numbers.
  #
  # @param num1 [Float] The first number.
  # @param num2 [Float] The second number.
  # @return [Float] The product of the two numbers.
  def self.multiply(num1, num2)
    num1 * num2
  end

  # Calculate the quotient of two numbers.
  #
  # @param num1 [Float] The first number (dividend).
  # @param num2 [Float] The second number (divisor).
  # @return [Float] The quotient of the two numbers.
  def self.divide(num1, num2)
    raise 'Division by zero' if num2 == 0
    num1 / num2
  end
end

# Set up the Cuba framework to create a simple web service.
Cuba.define do
  # Define a route to perform addition.
  on 'add/:a/:b' do |a, b|
    content_type 'text/plain', charset: 'utf-8'
    "#{MathUtilityTool.add(a.to_f, b.to_f)}"
  end

  # Define a route to perform subtraction.
  on 'subtract/:a/:b' do |a, b|
    content_type 'text/plain', charset: 'utf-8'
    "#{MathUtilityTool.subtract(a.to_f, b.to_f)}"
  end

  # Define a route to perform multiplication.
  on 'multiply/:a/:b' do |a, b|
    content_type 'text/plain', charset: 'utf-8'
    "#{MathUtilityTool.multiply(a.to_f, b.to_f)}"
  end

  # Define a route to perform division.
  on 'divide/:a/:b' do |a, b|
    content_type 'text/plain', charset: 'utf-8'
    begin
      "#{MathUtilityTool.divide(a.to_f, b.to_f)}"
    rescue => e
      "Error: #{e.message}"
    end
  end
end
