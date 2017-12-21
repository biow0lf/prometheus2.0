# frozen_string_literal: true

require 'rails_helper'

describe RPMCheckMD5 do
  it 'should verify md5 sum of srpm before import and return true for good srpm' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    expect(RPMCheckMD5).to receive(:`).with("export LANG=C && rpm -K --nogpg #{ file }").and_return("openbox-3.5.0-alt1.src.rpm: md5 OK\n")
    expect(RPMCheckMD5.check_md5(file)).to eq(true)
  end

  it 'should verify md5 sum of srpm before import and return false for broken srpm' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    expect(RPMCheckMD5).to receive(:`).with("export LANG=C && rpm -K --nogpg #{ file }").and_return('')
    expect(RPMCheckMD5.check_md5(file)).to eq(false)
  end
end
