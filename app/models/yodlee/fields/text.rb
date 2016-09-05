module Yodlee
  module Fields
    class Text < BaseField

      def input
        "<input class='string #{requirement}' id='#{name}' name='#{name}' size='#{size}' type='text' maxlength='#{maxlength}' value='#{value}' />"
      end

    end
  end
end