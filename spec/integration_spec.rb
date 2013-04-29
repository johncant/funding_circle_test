require 'spec_helper'
require 'timeout'
require 'pry'

describe "command line tool" do

  let(:options) { "-n 10 -f 2" }
  let(:command) { "bundle exec bin/funding_circle_test_primes #{options}" }
  let(:stdout) { `#{command}` }

  it "displays results in a table" do
    # Value
    stdout.should match(/\| *77 *\|/)

    # Column header
    stdout.should match(/\| *7 *\| *11 *\|/)

    # Row header
    stdout.should match(/^ *\| *7 *\|/)
  end
end

