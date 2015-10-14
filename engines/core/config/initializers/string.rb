class String
  def to_alphanumeric
    gsub(/[^0-9a-zA-Z]/i, "")
  end

  def to_bool
    self == "true"
  end

  def strip_tags
    ActionController::Base.helpers.strip_tags(self)
  end
end
