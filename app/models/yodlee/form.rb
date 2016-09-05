module Yodlee
  class Form

    attr_reader :fields, :wrapper

    def initialize opts
      @fields = opts[:fields]
      # LISTEN FOR A WRAPPER OPTION:
      @wrapper = opts[:wrapper]
    end

    def render
      fields.componentList.map do |element|
      type = element.fieldType.typeName.downcase.classify
       # PASS ALONG THE WRAPPER OPTION:
      Yodlee::Fields.const_get(type).new(field: element, wrapper: wrapper).render
      end.join('').squish
    end

  end
end