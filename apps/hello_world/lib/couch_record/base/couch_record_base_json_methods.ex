defmodule CouchRecord.Base.JsonMethods do
  @moduledoc """
  uses as mixins in CouchRecord.Document and CouchRecord.Design.Document, gives functions for json works with document
  """
  defmacro __using__([]) do
    quote do

      @doc """
      returns json with attrs from document
      """
      def attrs_to_json(fields, rec) do
        case Enum.empty? fields do
          true -> to_json(rec)
          false -> {with_attrs(fields, rec)}
        end
      end

      @doc """
      returns json from document withouth given attrs
      """
      def without_attrs_to_json(fields, rec) do
        fields = Enum.map keys(rec), fn(field) ->
          case include?(fields, field) do
            true -> []
            false -> field
          end
        end
        attrs_to_json(List.flatten(fields), rec)
      end

      @doc """
        returns json from document
      """
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