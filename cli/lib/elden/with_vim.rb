# frozen_string_literal: true

require_relative "vim"

module Elden
  module WithVim
    def with_vim(opts = nil, &)
      vim = Elden::Vim.new

      vim.instance_exec(opts, &)

      vim.arguments
    end
  end
end
