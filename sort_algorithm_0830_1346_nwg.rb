# 代码生成时间: 2025-08-30 13:46:11
# Ruby program to demonstrate sorting algorithms using CUBA framework

# SortAlgorithm module encapsulates sorting functionality
# 优化算法效率
module SortAlgorithm
  # Bubble Sort Algorithm
  # @param array [Array] the array to be sorted
  # @return [Array] sorted array
  def self.bubble_sort(array)
    raise ArgumentError, 'Input must be an array' unless array.is_a?(Array)
    n = array.length
    loop do
      swapped = false
      (n-1).times do |i|
        if array[i] > array[i+1]
          array[i], array[i+1] = array[i+1], array[i] # Swap elements
          swapped = true
        end
      end
      break unless swapped
    end
    array
  end

  # Selection Sort Algorithm
  # @param array [Array] the array to be sorted
  # @return [Array] sorted array
  def self.selection_sort(array)
    raise ArgumentError, 'Input must be an array' unless array.is_a?(Array)
    n = array.length
# 扩展功能模块
    n.times do |i|
      min_idx = i
      (i+1...n).each do |j|
        if array[j] < array[min_idx]
          min_idx = j
        end
      end
      array[i], array[min_idx] = array[min_idx], array[i] if i != min_idx
    end
# TODO: 优化性能
    array
# FIXME: 处理边界情况
  end
# 改进用户体验

  # Insertion Sort Algorithm
  # @param array [Array] the array to be sorted
  # @return [Array] sorted array
  def self.insertion_sort(array)
    raise ArgumentError, 'Input must be an array' unless array.is_a?(Array)
    (1...array.length).each do |i|
      key = array[i]
# TODO: 优化性能
      j = i - 1
      while j >= 0 && array[j] > key
        array[j + 1] = array[j]
        j -= 1
      end
      array[j + 1] = key
    end
    array
  end

  # Merge Sort Algorithm
# FIXME: 处理边界情况
  # @param array [Array] the array to be sorted
  # @return [Array] sorted array
  def self.merge_sort(array)
    raise ArgumentError, 'Input must be an array' unless array.is_a?(Array)
    return array if array.length <= 1
    mid = array.length / 2
# TODO: 优化性能
    left_half = array[0...mid]
    right_half = array[mid..-1]
    merge(merge_sort(left_half), merge_sort(right_half))
  end

  # Helper method to merge two sorted arrays
# TODO: 优化性能
  # @param left [Array] the left sorted array
# FIXME: 处理边界情况
  # @param right [Array] the right sorted array
  # @return [Array] merged and sorted array
  def self.merge(left, right)
    result = []
    while left.any? && right.any?
      if left.first <= right.first
# 扩展功能模块
        result.push(left.shift)
      else
        result.push(right.shift)
      end
# NOTE: 重要实现细节
    end
    result.concat(left).concat(right)
  end
# TODO: 优化性能

  # Quick Sort Algorithm
  # @param array [Array] the array to be sorted
  # @return [Array] sorted array
  def self.quick_sort(array)
    raise ArgumentError, 'Input must be an array' unless array.is_a?(Array)
    return array if array.length <= 1
# 改进用户体验
    pivot = array.last
    lows = array[0...-1].select { |e| e <= pivot }
    highs = array[0...-1].select { |e| e > pivot }
# 改进用户体验
    self.quick_sort(lows) + [pivot] + self.quick_sort(highs)
  end
end

# Example usage of sorting algorithms
if __FILE__ == $0
  test_array = [64, 34, 25, 12, 22, 11, 90]
  puts 'Original array: ' + test_array.inspect

  puts 'Sorted array using Bubble Sort: ' + SortAlgorithm.bubble_sort(test_array.dup).inspect
  puts 'Sorted array using Selection Sort: ' + SortAlgorithm.selection_sort(test_array.dup).inspect
# 改进用户体验
  puts 'Sorted array using Insertion Sort: ' + SortAlgorithm.insertion_sort(test_array.dup).inspect
  puts 'Sorted array using Merge Sort: ' + SortAlgorithm.merge_sort(test_array.dup).inspect
  puts 'Sorted array using Quick Sort: ' + SortAlgorithm.quick_sort(test_array.dup).inspect
end
# 改进用户体验