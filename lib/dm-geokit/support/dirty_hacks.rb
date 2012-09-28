class DataMapper::Query
  # Verifies that value of :fields option
  # refers to existing properties
  #
  # @api private
  def assert_valid_fields(fields, unique)
    fields = fields.to_ary

    model = self.model

    valid_properties = model.properties

    model.descendants.each do |descendant|
      valid_properties += descendant.properties
    end

    fields.each do |field|
      name = case field
               when Symbol, String
                 field
               when DataMapper::Property
                 field.name
               else
                 raise ArgumentError, "+options[:fields]+ entry #{field.inspect} of an unsupported object #{field.class}"
             end
      unless valid_properties.named?(name)
        raise ArgumentError, "+options[:fields]+ entry #{name.inspect} does not map to a property in #{model}"
      end
    end
  end
end


