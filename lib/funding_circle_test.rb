require "funding_circle_test/version"
require "stream"
require "text-table"


module FundingCircleTest

  def self.print_primes(opts)
    problem = Problem.new(opts)

    matrix = problem.sparse_results

    distinct_undisplayable_primes = problem.primes.repeated_combination(problem.dimensionality-2)
    distinct_undisplayable_primes.each do |extras|
      subtable = matrix

      # Scope the printed table
      unless extras.empty?
        puts "Cross section for #{extras.inspect}:"
        extras.each do |n|
          index = problem.primes.index(n)
          subtable = subtable[index]
        end
      end

      print_2d_table(subtable, problem.primes)
    end

  end

  private
  def self.print_2d_table(matrix_2d, primes)
    table = Text::Table.new
    table.head = ["Factor", primes].flatten
    table.rows = matrix_2d.each_with_index.map do |row, i|
      [primes[i], row].flatten
    end

    puts table
  end

  class Problem
    # O(n^f)

    def initialize(opts)
      @prime_count = opts[:n]
      @factor_count = opts[:f]
    end

    def dimensionality
      @factor_count
    end

    def primes
      @primes ||= FundingCircleTest.prime_number_stream.take(@prime_count)
    end

    def results
      @sparse_results ||= primes.repeated_combination(@factor_count).map do |factors|
        {factors => factors.inject(&:*)}
      end.inject(&:merge)
    end

    def dense_results
      @dense_results ||= build_results_matrix(@factor_count, true)
    end

    def sparse_results
      @dense_results ||= build_results_matrix(@factor_count, false)
    end

    def build_results_matrix(dimensionality, dense, factors=[])
      if dimensionality == 0
        if dense
          results[factors.sort]
        else
          results[factors]
        end
      else
        primes.map do |factor|
          build_results_matrix(dimensionality-1, dense, [factors, factor].flatten)
        end
      end
    end
  end

  def self.prime_number_stream

    @candidate_stream = Stream::ImplicitStream.new do |s|
      value = 1
      s.set_to_begin_proc = proc { value=1 }
      s.at_end_proc = proc {false}
      s.forward_proc = proc { value += 1 }
    end

    @candidate_stream.filtered do |n|
      divisors = 2..(n-1)
      divisors.none? { |d| n % d == 0 }
    end

  end
end
