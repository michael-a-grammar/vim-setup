# frozen_string_literal: true

module Elden
  module ShellCommand
    def self.included(base)
      base.extend(Elden::ShellCommand)

      module_to_prepend = Module.new

      base.define_singleton_method :method_added do |method_name|
        return unless @shell_command

        module_to_prepend
          .define_method(method_name) do |*args, **keyword_args, &block|
            result = if keyword_args.empty?
                       super(*args, &block)
                     else
                       super(*args, **keyword_args, &block)
                     end

            result.define_singleton_method(:to_shell_command) do
              flatten.join(" ").strip
            end

            result.define_singleton_method("run!") do
              `#{to_shell_command}`
            end

            result
          end

        disable_shell_command
      end

      base.prepend(module_to_prepend)
    end

    def shell_command = @shell_command = true

    private

    def disable_shell_command = @shell_command = false
  end
end
