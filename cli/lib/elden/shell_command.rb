# frozen_string_literal: true

module Elden
  module ShellCommand # rubocop:todo Style/Documentation rubocop:disable Metrics/MethodLength
    def self.included(base) = shell_command(base)

    def self.shell_command(module_to_be_prepended) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      module_to_prepend = Module.new do |new_module|
        new_module.class.define_method :prepended do |base| # rubocop:disable Metrics/MethodLength
          TracePoint.trace(:end) do |trace|
            if base == trace.self
              base.instance_methods(false).each do |method_name|
                new_module.define_method method_name do |*args, **keyword_args| # rubocop:disable Metrics/MethodLength
                  result = if keyword_args.empty?
                             super(*args)
                           else
                             super(*args, **keyword_args)
                           end
                           .join(" ")
                           .strip

                  result.define_singleton_method(:to_shell_command) { to_s }

                  result.define_singleton_method :run do
                    if Elden::ShellCommand::ENABLED
                      `#{to_shell_command}`
                    else
                      to_shell_command
                    end
                  end

                  result
                end
              end

              trace.disable
            end
          end
        end
      end

      module_to_be_prepended.prepend(module_to_prepend)
    end
  end
end
