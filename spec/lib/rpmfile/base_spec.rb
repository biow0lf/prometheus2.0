require 'spec_helper'
require 'rpmfile'

describe RPMFile::Base do
  context '#read_raw' do
    it 'does read raw value' do
      queryformat = '%{NAME}'
      command = 'rpm'
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      opts = ['-qp', "--queryformat=#{ queryformat }", file]
      name = 'catpkt'
      reader = double('reader')
      rpm = RPMFile::Base.new(file, reader)
      expect(reader).to receive(:run).with(command, opts).and_return({stdout: name, exitstatus: 0})
      expect(rpm.read_raw(queryformat)).to eq(name)
    end
  end

  context '#read_tag' do
    it 'does read any tag' do
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      name = 'catpkt'
      rpm = RPMFile::Base.new(file)
      expect(rpm).to receive(:read_raw).with('%{NAME}').and_return(name)
      expect(rpm.read_tag('NAME')).to eq(name)
    end
  end

  context 'define_method' do
    # let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }
    # let(:rpm) { RPMFile::Base.new(file) }

    it 'does return string' do
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      rpm = RPMFile::Base.new(file)
      tag = RPMFile::Base::RPM_STRING_TAGS.first
      expect { rpm.send(tag) }.not_to raise_exception
      expect(rpm.send(tag)).to be_instance_of(String)
    end

    it 'does return int' do
      file = 'spec/data/xmms-1.2.11-alt11.src.rpm'
      rpm = RPMFile::Base.new(file)
      tag = RPMFile::Base::RPM_INT_TAGS.first
      expect { rpm.send(tag) }.not_to raise_exception
      expect(rpm.send(tag)).to be_instance_of(Fixnum)
    end

    it 'does return time' do
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      rpm = RPMFile::Base.new(file)
      tag = RPMFile::Base::RPM_TIME_TAGS.first
      expect { rpm.send(tag) }.not_to raise_exception
      expect(rpm.send(tag)).to be_instance_of(Time)
    end
  end

  context '#filename' do
    it 'does raise exception' do
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      rpm = RPMFile::Base.new(file)
      expect { rpm.filename }.to raise_exception(NotImplementedError)
    end
  end

  context '#md5' do
    it 'does return md5' do
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      rpm = RPMFile::Base.new(file)
      expect(rpm).to receive(:`).with("md5sum #{ file }").and_return("35f0f45bfbcdaf8754713fc1c97f8068  spec/data/catpkt-1.0-alt5.src.rpm\n")
      expect(rpm.md5).to eq('35f0f45bfbcdaf8754713fc1c97f8068')
    end
  end

  context '#size' do
    it 'does return size' do
      file = 'spec/data/catpkt-1.0-alt5.src.rpm'
      size = 14_216
      rpm = RPMFile::Base.new(file)
      expect(File).to receive(:size).with(file).and_return(size)
      expect(rpm.size).to eq(size)
    end
  end
end
