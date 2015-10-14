module Mesin
  module Core::Concerns::Models::AutoTimestamp
    extend ActiveSupport::Concern
    
    included do
      after_initialize :test
    end

    def test
      p "opan"
    end
  end # end Core::Concerns::Models::AutoTimestamps
end
