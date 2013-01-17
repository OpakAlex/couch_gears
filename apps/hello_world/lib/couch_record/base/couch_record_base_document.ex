defmodule CouchRecord.Base.Document do
  defmacro __using__([]) do
    quote do

      def parse_to_record(body, db_name) do
        document = document.db_name(db_name)
        document.new(body)
      end

      def create_document(db_name, body) do
        document = document.db_name(db_name)
        doc = document.new(body)
        doc.save!
      end
    end
  end
end