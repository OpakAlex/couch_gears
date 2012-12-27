defmodule CouchRecord.Design.Validation do
  defmacro __using__([]) do
    quote do

      def validate_doc_update(rec) do
        rec.attrs[:validate_doc_update]
      end

    end
  end
end