# frozen_string_literal: true

require "minitest/autorun"
require "minitest/pride"

$LOAD_PATH << File.expand_path("../../lib", __FILE__)
Thread.abort_on_exception = true

require "n_plus_one_control/minitest"
require "benchmark"
require "active_record"
require "factory_girl"
require "pry-byebug"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

Dir["#{File.dirname(__FILE__)}/../spec/support/**/*.rb"].each { |f| require f }

module TransactionalTests
  def setup
    ActiveRecord::Base.connection.begin_transaction(joinable: false)
    super
  end

  def teardown
    super
    ActiveRecord::Base.connection.rollback_transaction
  end
end

Minitest::Test.prepend TransactionalTests
Minitest::Test.include FactoryGirl::Syntax::Methods
