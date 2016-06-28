class ImportSrpmFile < Rectify::Command
  attr_reader :branch, :file

  def initialize(branch, file)
    @branch = branch
    @file = file
  end

  def call
    return broadcast(:already_imported) if file_already_imported?

    transaction do

    end

    broadcast(:ok)
  end

  private

  def file_already_imported?
    Redis.current.exists("#{ branch.name }:#{ File.basename(file) }")
  end
end
