module Validator
  module Matchers
    # TODO: Document and cleanup.
    module ValidatorSpecHelper
      DEFAULT_ATTRIBUTE_NAME = :value

      # Auto extend validator specs when included
      def self.included(base)
        base.instance_eval do
          let(:validator_name) do
            RSpec.current_example.full_description.match(/\A[\w:]+Validator/)[0]
          end

          let(:validator_class) { Object.const_get(validator_name) }

          let(:validator_type) do
            if validator_class.ancestors.include? ActiveModel::EachValidator
              ActiveModel::EachValidator
            else
              ActiveModel::Validator
            end
          end

          let(:validation_name) do
            validator_name.underscore.gsub(/_validator\Z/, '')
          end

          let(:attribute_names) { [DEFAULT_ATTRIBUTE_NAME] }

          let(DEFAULT_ATTRIBUTE_NAME) { nil }

          let(:options) { nil }

          # This smells like it can be extracted into two objects.
          let(:model_class) do
            example_group = self
            Struct.new(*attribute_names) do
              include ActiveModel::Validations

              def self.name
                'ValidatorModelMock'
              end

              if example_group.validator_type == ActiveModel::EachValidator
                args =
                  {
                    example_group.validation_name.to_sym => (
                      example_group.options || true
                    )
                  }
                validates DEFAULT_ATTRIBUTE_NAME, args
              else
                if example_group.options.nil?
                  validates_with example_group.validator_class
                else
                  validates_with example_group.validator_class,
                    example_group.options
                end
              end
            end
          end

          let(:validator_model_mock) do
            attributes = attribute_names.map { |name| eval("#{name}") }
            model_class.new(*attributes)
          end
        end
      end
    end
  end
end
