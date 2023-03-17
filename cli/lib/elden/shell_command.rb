# frozen_string_literal: true

module Elden
  module ShellCommand
    def self.included(base)
      shell_command(base)

      base.define_singleton_method :method_added do |method_name|
        @shell_commands ||= []

        unless @shell_command_ignore.nil?
          @shell_commands << {
            method_name:,
            ignore: @shell_command_ignore
          }

          @shell_command_ignore = nil
        end
      end
    end

    def self.shell_command(module_to_be_prepended)
      module_to_prepend = Module.new do |new_module|
        new_module.class.define_method(:prepended) do |base|
          TracePoint.trace(:end) do |trace|
            if base == trace.self
              base.instance_methods(false).each do |method_name|
                next if base
                        .instance_variable_get("@shell_commands")
                        .any? do |shell_command|
                          shell_command in {method_name: ^method_name, ignore: true}
                        end

                new_module.define_method(method_name) do |*args, **keyword_args, &block|
                  result = if keyword_args.empty?
                             super(*args, &block)
                           else
                             super(*args, **keyword_args, &block)
                           end

                  result.define_singleton_method(:to_shell_command) do
                    flatten.join(" ").strip
                  end

                  result.define_singleton_method(:run) do
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
