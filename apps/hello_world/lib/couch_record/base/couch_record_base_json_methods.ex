defmodule CouchRecord.Base.JsonMethods do
  defmacro __using__([]) do
    quote do

      def attrs_to_json(fields, rec) do
        case Enum.empty? fields do
          true -> to_json(rec)
          false -> {with_attrs(fields, rec)}
        end
      end

      def without_attrs_to_json(fields, rec) do
        fields = Enum.map keys(rec), fn(field) ->
          case include?(fields, field) do
            true -> []
            nil -> field
          end
        end
        attrs_to_json(List.flatten(fields), rec)
      end

      def to_json(rec) do
        {rec.body}
      end

      #private
      defp with_attrs(fields, rec) do
        Enum.map fields, fn(field) ->
          {to_binary(field), rec.attrs[field]}
        end
      end

    end
  end
end