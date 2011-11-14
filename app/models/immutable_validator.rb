# encoding: utf-8

class ImmutableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "cannot be changed after creation" if record.send("#{attribute}_changed?") && !record.new_record?
  end
end
