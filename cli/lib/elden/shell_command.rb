# frozen_string_literal: true

module Elden
  module ShellCommand # rubocop:todo Style/Documentation
    def self.included(base) = shell_command(base)

    def self.shell_command(base)
      module_to_prepend = Module.new do |new_module|
        new_module.class.define_method :prepended do |klass|
          TracePoint.trace(:end) do |trace|
            if klass == trace.self
              klass.instance_methods(false).each do |method_name|
                new_module.define_method method_name do |*args, **keyword_args|
                  result = if keyword_args.empty?
                             super(*args)
                           else
                             super(*args, **keyword_args)
                           end
                           .join(" ")
                           .strip

                  result.define_singleton_method(:to_shell_command) { p "`#{self}`" }

                  result
                end
              end

              trace.disable
            end
          end
        end
      end

      base.prepend(module_to_prepend)
    end
  end
end
