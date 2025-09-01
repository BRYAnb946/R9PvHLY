# 代码生成时间: 2025-09-02 05:52:01
# 测试报告生成器
# 使用 RUBY 和 CUBA 框架实现

require 'cuba'
require 'fileutils'
require 'erb'
require 'json'
require 'date'

# 定义 TestReport 生成器类
class TestReportGenerator
  attr_accessor :test_results, :output_path

  # 初始化方法，接收测试结果和输出路径
  def initialize(test_results, output_path)
    @test_results = test_results
    @output_path = output_path
  end

  # 生成测试报告
  def generate
    return false unless test_results && output_path

    template_path = File.join(File.dirname(__FILE__), 'report_template.erb')
    template = ERB.new(File.read(template_path))
    report_content = template.result(binding)

    report_file_path = File.join(output_path, "TestReport_#{DateTime.now.strftime('%Y%m%d%H%M%S')}.html")
    File.write(report_file_path, report_content)

    true
  end

  # 添加测试结果
  def add_result(test_name, test_status, test_message)
    @test_results[test_name] = { status: test_status, message: test_message }
  end

  # 检查报告目录是否存在，不存在则创建
  def ensure_output_path_exists
    FileUtils.mkdir_p(output_path) unless Dir.exist?(output_path)
  end
end

# CUBA 路由配置
Cuba.define do
  # 路由到测试报告生成器
  on get, 'generate_report' do
    params = request.params
    test_results = params['results'] ? JSON.parse(params['results']) : {}
    output_path = params['output'] || './reports'
    generator = TestReportGenerator.new(test_results, output_path)
    generator.ensure_output_path_exists

    if generator.generate
      res.write("Report generated successfully.")
    else
      res.status = 400
      res.write("Failed to generate report.")
    end
  end
end
