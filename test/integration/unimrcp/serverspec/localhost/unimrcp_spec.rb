require 'spec_helper'

describe 'UniMRCP' do
  describe command('/usr/local/unimrcp/bin/unimrcpclient --version') do
    it { should return_stdout '1.1.0' }
  end
end
