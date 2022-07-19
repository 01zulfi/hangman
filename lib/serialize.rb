# frozen_string_literal: true

require 'json'

# serialize module
module Serialize
  def to_json(object)
    JSON.generate(object)
  end

  def from_json(json_string)
    JSON.parse(json_string)
  end
end
