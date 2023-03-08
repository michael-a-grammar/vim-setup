# frozen_string_literal: true

module Elden
  module ShellCommands
    module Extensions # rubocop:todo Style/Documentation
      def shell_command(arguments) = arguments.join(" ").strip
    end
  end
end
