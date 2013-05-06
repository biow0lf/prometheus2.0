class ImmutableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.send("#{attribute}_changed?") && !record.new_record?
      record.errors[attribute] << 'cannot be changed after creation'
    end
  end
end
