# frozen_string_literal: true

require 'rails_helper'

module Extractor
  module RPM
    describe Base do
      it 'should raise Extractor::RPM::CommandNotFound exception' do
        file = Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.src.rpm')

        expect { described_class.new(file, command: 'rpm-not-found-command').name }.to raise_error(Extractor::RPM::CommandNotFound)
      end
    end
  end
end
