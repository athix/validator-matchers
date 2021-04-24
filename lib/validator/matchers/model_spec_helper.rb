module Validator
  module Matchers
    # FIXME: This is really brittle, and poorly written in general. Will replace shortly.
    module ModelSpecHelper
      VALIDATOR_REGEX = %r{^(?:validate_)(.+)_of}

      def self.included(base)
        base.class_eval do
          def respond_to_missing?(method_name, *)
            (method_name =~ VALIDATOR_REGEX) || super
          end

          def method_missing(method_name, *args, &block)
            if regex = method_name.to_s.match(VALIDATOR_REGEX)
              validator_name = regex[1]
              validator_class_name = validator_name.camelcase + 'Validator'

              RSpec::Matchers.define method_name do |dynamic_matcher|
                match do |model|
                  model_validators =
                    model._validators[args.first].map{ |v| v.class.to_s }
                  model_validators.include?(validator_class_name)
                end

                failure_message do |model|
                  model.class.to_s + ' does not ' +
                  method_name.to_s.humanize.downcase + ' :' + args.first.to_s
                end

                failure_message_when_negated do |model|
                  model.class.to_s + ' does ' +
                  method_name.to_s.humanize.downcase + ' :' + args.first.to_s
                end

                description do |model|
                  method_name.to_s.humanize.downcase + ' :' + args.first.to_s
                end
              end

              self.__send__(method_name, args, block)
            else
              super
            end
          end
        end
      end
    end
  end
end
