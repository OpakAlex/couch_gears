defmodule CouchRecord.DocAttrs do
  defmacro __using__(opts) do
    quote do

      def _id(rec) do
        rec.attrs[:_id]
      end

      def _rev(rec) do
        rec.attrs[:_rev]
      end

    end
  end
end