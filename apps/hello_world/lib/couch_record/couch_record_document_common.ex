defmodule CouchRecord.DocumentCommon do
  defmacro __using__(opts) do
    quote do

      defdelegate get_doc(db_name, id), to: CouchRecord.Db

      def parse_to_record(body, db_name) do
        document = var!(document).db_name(db_name)
        document.body(body)
      end

      def create_document(db_name, body) do
        document = document.db_name(db_name)
        doc = document.body(body)
        doc.save!
      end
    end
  end
end