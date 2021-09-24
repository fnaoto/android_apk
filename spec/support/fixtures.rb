# frozen_string_literal: true

FIXTURE_DIR = File.join(File.dirname(__FILE__), "..", "fixture")

def fixture_file(*paths)
  File.join(FIXTURE_DIR, *paths)
end