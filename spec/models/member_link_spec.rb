require 'rails_helper'

describe MemberLink do

  it 'has a valid factory' do
    expect(build(:member_link)).to be_valid
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :link }

  it { is_expected.to belong_to(:member) }

end
