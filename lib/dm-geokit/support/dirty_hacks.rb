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
      case field
        when Symbol, String
          unless valid_properties.named?(field)
            raise ArgumentError, "+options[:fields]+ entry #{field.inspect} does not map to a property in #{model}"
          end

        when DataMapper::Property
          unless valid_properties.include?(field) || valid_properties.named?(field.name)
            raise ArgumentError, "+options[:field]+ entry #{field.name.inspect} does not map to a property in #{model}"
          end
        when DataMapper::Query::Operator
          # Do nothing
        else
          raise ArgumentError, "+options[:fields]+ entry #{field.inspect} of an unsupported object #{field.class}"
      end
    end
  end
end


