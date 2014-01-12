require 'spec_helper'

describe 'UniMRCP' do
  describe command('/usr/local/unimrcp/bin/unimrcpclient --version') do
    it { should return_stdout '1.1.0' }
  end

  describe file('/usr/local/unimrcp/plugin/mrcpflite.so') do
    it { should be_file }
  end

  describe file('/usr/local/unimrcp/plugin/mrcppocketsphinx.so') do
    it { should be_file }
  end
end
