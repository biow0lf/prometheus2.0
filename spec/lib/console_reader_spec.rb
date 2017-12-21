# frozen_string_literal: true

require 'spec_helper'
require 'console_reader'

describe ConsoleReader do
  let(:command) { 'rpm' }

  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

  let(:opts) { ['-qp', '--queryformat=%{NAME}', file] }

  describe '#run' do
    it 'does read console app output' do
      expect(subject.run(command, opts))
        .to eq({ stdout: 'catpkt', stderr: '', exitstatus: 0 })
    end
  end
end
