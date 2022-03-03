class VimCommand
  attr_reader command_name, method_name

  def initialize(command_prefix, command, &customise_command_name)
    @method_name  = "#{command_prefix}_#{command}"
    @command_name = "#{command_prefix.capitalize}#{command}"

    yield self if block_given?
  end
end

