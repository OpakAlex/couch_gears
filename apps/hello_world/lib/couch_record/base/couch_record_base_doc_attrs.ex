defmodule CouchRecord.Base.DocAttrs do
  defmacro __using__([]) do
    quote do

      def attrs(dict, rec) do
        document(rec, attrs: dict)
      end

      def attrs(document(attrs: attrs)) do
        attrs
      end

      def attr?(name, rec) do
        Dict.has_key?(rec.attrs, name)
      end

      def _id(rec) do
        rec.attrs[:_id]
      end

      def _rev(rec) do
        rec.attrs[:_rev]
      end

    end
  end
end