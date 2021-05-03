# 'frozen_string_literal' => true

module Rom
  ROM_ROOT = ENV['ROM_ROOT'] || File.expand_path("~/.rom")
  CACHE_DIR = ENV['CACHE_DIR'] || "#{ROM_ROOT}/cache"
  GAME_DIR = ENV['GAME_DIR'] || "#{ROM_ROOT}/games"
  LOG_DIR = ENV['LOG_DIR'] || "#{ROM_ROOT}/logs"
end