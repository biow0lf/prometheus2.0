# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { should be_a(ApplicationRecord) }

  it 'should return true for @altlinux.org emails' do
    expect(User.new(email: 'icesik@altlinux.org').member?).to eq(true)
  end

  it 'should return true for @altlinux.ru emails' do
    expect(User.new(email: 'icesik@altlinux.ru').member?).to eq(true)
  end

  it 'should return false for non altlinux team member' do
    expect(User.new(email: 'user@email.com').member?).to eq(false)
  end

  it 'should deny change email' do
    user = create(:user, :confirmed)
    user.email = 'icesik@altlinux.org'
    expect(user.save).to eq(false)
  end

  describe '#login' do
    before do
      expect(subject).to receive(:email) do
        double.tap do |a|
          expect(a).to receive(:split).with('@') do
            double.tap do |b|
              expect(b).to receive(:first)
            end
          end
        end
      end
    end

    specify { expect { subject.login }.not_to raise_error }
  end
end
