class Vim
  @vim      = 'nvim -n'
  @commands = []

  def self.add_command(command)
    command = command.to_sym

    @commands.append command unless @commands.include? command

    self
  end

  def self.call
    add_command :qa

    @commands.map! { |command| "-c #{command}" }

    commands = @commands.join ' '

    @commands.clear

    "#{@vim} #{commands}"
  end
end

%i[install clean update].each do |e|
  Vim.define_singleton_method("plug_#{e}") do
    add_command("Plug#{e.capitalize}")
  end
end
