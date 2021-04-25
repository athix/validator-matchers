require 'rspec/core'

module Validator
  module Matchers
    autoload :ModelSpecHelper,     'validator/matchers/model_spec_helper'
    autoload :ValidatorSpecHelper, 'validator/matchers/validator_spec_helper'
    autoload :VERSION,             'validator/matchers/version'
  end
end

##
# Automatically configure RSpec to support validator specs.
#
RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{/spec/validators/}) do |metadata|
    metadata[:type] = :validator
  end

  config.include Validator::Matchers::ModelSpecHelper,     type: :model
  config.include Validator::Matchers::ValidatorSpecHelper, type: :validator
end
