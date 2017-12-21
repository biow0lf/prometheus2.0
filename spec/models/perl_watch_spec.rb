# frozen_string_literal: true

require 'rails_helper'

describe PerlWatch do
  it { should be_a(ApplicationRecord) }

  it { should validate_presence_of(:name) }

  # it 'should import data from CPAN' do
  #   page = File.read('spec/data/02packages.details.txt')
  #   url = 'http://www.cpan.org/modules/02packages.details.txt'
  #   FakeWeb.register_uri(:get, url, response: page)
  #
  #   expect { PerlWatch.import_data(url) }.to change(PerlWatch, :count).by(1)
  #   expect(PerlWatch.count).to eq(1)
  #   perlwatch = PerlWatch.first
  #   expect(perlwatch.name).to eq('AnyEvent::ZeroMQ')
  #   expect(perlwatch.version).to eq('0.01')
  #   expect(perlwatch.path).to eq('J/JR/JROCKWAY/AnyEvent-ZeroMQ-0.01.tar.gz')
  # end
end
