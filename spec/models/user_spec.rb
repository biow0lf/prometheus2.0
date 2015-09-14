require 'rails_helper'

describe User do
  context 'DB Indexes' do
    specify { should have_db_index(:confirmation_token).unique(true) }
    specify { should have_db_index(:email).unique(true) }
    specify { should have_db_index(:reset_password_token).unique(true) }
  end

  it 'should return login on #login' do
    expect(User.new(email: 'icesik@altlinux.org').login).to eq('icesik')
  end

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
    user = create(:user_confirmed)
    user.email = 'icesik@altlinux.org'
    expect(user.save).to eq(false)
  end
end
