# frozen_string_literal: true

require 'rails_helper'

describe RPMCheckMD5 do
  let(:valid_file) { './spec/data/catpkt-1.0-alt5.src.rpm' }
  let(:non_exist_file) { './spec/data/invalid-0.0-alt0.src.rpm' }
  let(:broken_file) { './spec/data/broken-1.0-alt5.src.rpm' }

  it 'should verify md5 sum of srpm before import and return true for good srpm' do
    expect(RPMCheckMD5.check_md5(valid_file)).to be_truthy
  end

  it 'should verify md5 sum of srpm before import and return false for non exist srpm' do
    expect(RPMCheckMD5.check_md5(non_exist_file)).to be_falsey
  end

  it 'should verify md5 sum of srpm before import and return false for broken srpm' do
    expect(RPMCheckMD5.check_md5(broken_file)).to be_falsey
  end
end
