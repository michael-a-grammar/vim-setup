require 'rake'

class Vim
  include Rake::FileUtilsExt

  @vim      = 'nvim'
  @flags    = ['n']
  @commands = []

  def self.add_command(command)
    command = command.to_sym

    @commands.append command unless @commands.include? command

    self
  end

  def self.build
    add_command :qa

    flags    = @flags.map { |flag| "-#{flag}" }
    commands = @commands.map { |command| "-c #{command}" }

    @commands.clear

    options = flags.concat commands

    [@vim, options]
  end

  def self.run
    vim, options = *build

    sh vim, *options
  end
end

%i[install clean update upgrade].each do |e|
  Vim.define_singleton_method("plug_#{e}") do
    add_command("Plug#{e.capitalize}")
  end
end
