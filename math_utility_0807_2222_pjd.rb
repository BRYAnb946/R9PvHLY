# 代码生成时间: 2025-08-07 22:22:59
# encoding: UTF-8

# MathUtility模块是一个数学计算工具集，包含基本的数学操作。
# 它遵循RUBY最佳实践，易于理解和维护。
module MathUtility
  # 计算两个数的和
  def self.add(a, b)
    a + b
  end

  # 计算两个数的差
  def self.subtract(a, b)
    a - b
  end

  # 计算两个数的乘积
  def self.multiply(a, b)
    a * b
  end

  # 计算两个数的商，如果分母为0，则返回错误
  def self.divide(a, b)
    raise 'Cannot divide by zero' if b == 0
    a.to_f / b
  end

  # 计算一个数的平方
  def self.square(a)
    a * a
  end

  # 计算一个数的立方
  def self.cube(a)
    a * a * a
  end

  # 计算一个数的绝对值
  def self.abs(a)
    a.abs
  end

  # 计算一个数的平方根，如果数为负，则返回错误
  def self.sqrt(a)
    raise 'Cannot calculate square root of a negative number' if a < 0
    Math.sqrt(a)
  end

  # 计算一个数的立方根
  def self.cbrt(a)
    a ** (1.0 / 3)
  end
end