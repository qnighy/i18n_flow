require_relative 'util'

class I18nFlow::CLI
  require_relative 'cli/copy_command'
  require_relative 'cli/format_command'
  require_relative 'cli/help_command'
  require_relative 'cli/lint_command'
  require_relative 'cli/read_config_command'
  require_relative 'cli/search_command'
  require_relative 'cli/split_command'
  require_relative 'cli/version_command'

  COMMANDS = {
    'copy'        => CopyCommand,
    'format'      => FormatCommand,
    'help'        => HelpCommand,
    'lint'        => LintCommand,
    'read_config' => ReadConfigCommand,
    'search'      => SearchCommand,
    'split'       => SplitCommand,
    'version'     => VersionCommand,
  }

  attr_reader :args
  attr_reader :command
  attr_reader :global_options

  def initialize(args)
    @global_options = I18nFlow::Util.parse_options(args)
    @command, *@args = args
  end

  def run
    if global_options['v'] || global_options['version']
      @command = 'version'
    end
    if global_options['h']
      @command = 'help'
    end

    command_class = COMMANDS[command] || COMMANDS['help']
    command_class.new(args).invoke!
  end
end
