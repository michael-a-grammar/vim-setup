# frozen_string_literal: true

require_relative "elden/version"
require_relative "elden/shell"

Elden::ShellCommand::ENABLED = true

@shell = Elden::Shell.new
