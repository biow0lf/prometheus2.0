# https://rails.lighthouseapp.com/projects/8994/tickets/3174-add-support-for-postgresql-citext-column-type
require 'arel'

module Arel
  module Predicates
    class Match < Binary
      def predicate_sql
        'ILIKE'
      end
    end
    class NotMatch < Binary
      def predicate_sql
        'NOT ILIKE'
      end
    end
  end
end