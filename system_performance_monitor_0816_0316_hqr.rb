# 代码生成时间: 2025-08-16 03:16:53
# system_performance_monitor.rb

# 系统性能监控工具
# 使用RUBY和CUBA框架

require 'cuba'
require 'sys-cpu'
require 'sys-mem'
require 'sys-disk'
require 'sys/loadavg'
require 'json'

class SystemPerformanceMonitor < Cuba
  # 首页，显示性能概览
  define do
    on get do
      res.write system_performance_overview.to_json
    end

    # 获取CPU性能数据
    on get, 'cpu' do
      res.write cpu_performance.to_json
    end

    # 获取内存性能数据
    on get, 'memory' do
      res.write memory_performance.to_json
    end

    # 获取磁盘性能数据
    on get, 'disk' do
      res.write disk_performance.to_json
    end

    # 获取系统负载性能数据
    on get, 'load' do
      res.write load_performance.to_json
    end
  end

  private

  # 性能概览
  def system_performance_overview
    {
      cpu: cpu_performance,
      memory: memory_performance,
      disk: disk_performance,
      load: load_performance
    }
  end

  # CPU性能数据
  def cpu_performance
    begin
      cpu_stats = Sys::CPU.cpu_times
      {
        total_time: cpu_stats[0] + cpu_stats[1] + cpu_stats[2] + cpu_stats[3],
        user: cpu_stats[0],
        nice: cpu_stats[1],
        system: cpu_stats[2],
        iowait: cpu_stats[3]
      }
    rescue StandardError => e
      { error: "Unable to retrieve CPU data: #{e.message}" }
    end
  end

  # 内存性能数据
  def memory_performance
    begin
      memory_stats = Sys::Mem.info
      {
        total: memory_stats[:total],
        available: memory_stats[:available],
        used: memory_stats[:used],
        used_percent: memory_stats[:used_percent]
      }
    rescue StandardError => e
      { error: "Unable to retrieve memory data: #{e.message}" }
    end
  end

  # 磁盘性能数据
  def disk_performance
    begin
      disk_stats = Sys::Disk.stats
      {
        total: disk_stats[:total],
        used: disk_stats[:used],
        available: disk_stats[:available],
        used_percent: disk_stats[:used_percent]
      }
    rescue StandardError => e
      { error: "Unable to retrieve disk data: #{e.message}" }
    end
  end

  # 系统负载性能数据
  def load_performance
    begin
      loadavg_stats = Sys::LoadAvg.loadavg
      {
        one_minute: loadavg_stats[0],
        five_minutes: loadavg_stats[1],
        fifteen_minutes: loadavg_stats[2]
      }
    rescue StandardError => e
      { error: "Unable to retrieve load data: #{e.message}" }
    end
  end
end

# 运行系统性能监控工具
Rack::Handler::Thin.run(SystemPerformanceMonitor)