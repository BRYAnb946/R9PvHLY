# 代码生成时间: 2025-09-06 12:16:55
# 数据分析器
# 使用RUBY和CUBA框架

require 'cuba'
require 'json'
require 'date'

# 定义数据分析器类
class DataAnalyzer
  # 初始化方法
  def initialize(data)
    @data = data
  end

  # 计算平均值
  def calculate_average
    total = 0
    @data.each { |value| total += value }
    if @data.empty?
      raise 'No data to calculate average'
    else
      total / @data.size.to_f
    end
  end

  # 计算中位数
  def calculate_median
    sorted_data = @data.sort
    midpoint = sorted_data.size / 2
    if sorted_data.size.odd?
      sorted_data[midpoint]
    else
      (sorted_data[midpoint - 1] + sorted_data[midpoint]) / 2.0
    end
  end

  # 计算标准差
  def calculate_std_dev
    mean = calculate_average
    variance = 0
    @data.each { |value| variance += (value - mean) ** 2 }
    variance / @data.size.to_f
    Math.sqrt(variance)
  end

  # 计算数据峰值
  def calculate_peak
    @data.max
  end

  # 计算数据谷值
  def calculate_trough
    @data.min
  end
end

# CUBA框架路由设置
Cuba.define do
  # 定义根路由，返回数据分析器的HTML页面
  on root do
    res.write 'Data Analyzer'
  end

  # 定义POST请求，接收JSON格式的数据
  on post do
    on 'analyze' do
      # 解析JSON请求体
      request.body.rewind
      data = JSON.parse(request.body.read)

      # 检查数据格式
      unless data.is_a?(Array) && data.all? { |i| i.is_a?(Numeric) }
        throw 400, 'Invalid data format'
      end

      # 创建数据分析器实例
      analyzer = DataAnalyzer.new(data)

      # 计算统计数据
      average = analyzer.calculate_average
      median = analyzer.calculate_median
      std_dev = analyzer.calculate_std_dev
      peak = analyzer.calculate_peak
      trough = analyzer.calculate_trough

      # 返回统计结果
      res.write JSON.pretty_generate({
        average: average,
        median: median,
        std_dev: std_dev,
        peak: peak,
        trough: trough
      })
    end
  end
end
