defmodule CouchRecord.Design.Validation do
  defmacro __using__([]) do
    quote do

      @doc """
      returns validate_doc_update for design documents validate_doc_update
      """
      def validate_doc_update(rec) do
        rec.attrs[:validate_doc_update]
      end

    end
  end
end