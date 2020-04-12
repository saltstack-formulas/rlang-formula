# frozen_string_literal: true

control 'rlang package' do
  title 'should be installed'

  describe package('r-base') do
    it { should be_installed }
  end
end
