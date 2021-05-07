# 'frozen_string_literal' => true

require 'fileutils'
require 'ostruct'

module Rom
  class Game < OpenStruct
    def filename
      "#{self.filepath}/#{File.read(self.state_filename)}"
    end

    def filepath
      "#{Rom::GAME_DIR}/#{self.repo.name}/#{self.platform}/#{self.region}"
    end

    def install
      self.repo.install self do |file, filename|
        FileUtils.mkdir_p(self.filepath)
        FileUtils.cp(file, "#{self.filepath}/#{filename}")
        self.update_state filename
      end
    end

    def installed?
      File.exists? self.state_filename
    end

    def state_filename
      "#{Rom::STATE_DIR}/#{self.repo.name}/#{self.platform}/#{self.region}/#{self.id}"
    end

    def to_s
      "#{self.id} - #{self.name} - #{self.region}#{self.installed? ? " (#{shell.set_color 'installed', :green})" : ''}"
    end

    def uninstall
      FileUtils.rm_rf self.filename
      FileUtils.rm_rf self.state_filename
    end

    def update_state filename
      FileUtils.mkdir_p("#{Rom::STATE_DIR}/#{self.repo.name}/#{self.platform}/#{self.region}")
      File.write(self.state_filename, filename)
    end

    private
    def shell
      @shell ||= Thor::Shell::Color.new
    end
  end
end
