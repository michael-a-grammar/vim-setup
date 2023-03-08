# frozen_string_literal: true

module Elden
  module ShellCommands
    module Invoke # rubocop:todo Style/Documentation
      def self.included(base)
        base.instance_methods(false).each do |method_name|
          method = base.instance_method(method_name)
          base.define_method "invoke_#{method_name}" do |*args, &block|
            `#{method.bind(self).call(*args, &block)}`
          end
        end
      end
    end
  end
end
