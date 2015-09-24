require 'helper'

class TestLicenseeProjectFile < Minitest::Test

  def setup
    @repo = Rugged::Repository.new(fixture_path("licenses.git"))
    blob, _ = Rugged::Blob.to_buffer(@repo, 'bcb552d06d9cf1cd4c048a6d3bf716849c2216cc')
    @file = Licensee::Project::LicenseFile.new(blob)
    @gpl = Licensee::License.find "GPL-3.0"
    @mit = Licensee::License.find "MIT"
  end

  should "read the file" do
    assert @file.content =~ /MIT/
  end

  should "match the license" do
    assert_equal "mit", @file.license.key
  end

  should "calculate confidence" do
    assert_equal 100, @file.confidence
  end

  should "parse the attribution" do
    assert_equal "Copyright (c) 2014 Ben Balter", @file.attribution
  end

end
