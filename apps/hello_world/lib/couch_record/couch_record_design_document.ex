defmodule CouchRecord.DesignDocument do
  defmacro __using__(opts) do
    quote do
      defrecordp :document, unquote(opts)

      use CouchRecord.Base
      use CouchRecord.AbstractDesignDocument
    end
  end
end

defmodule CouchRecord.DesignDocument do
    use CouchRecord.DesignDocument, [db_name: nil, body: nil, attrs: nil]

    defdelegate get_doc(db_name, id), to: CouchRecord.Db
    defdelegate save!(db_name, body), to: CouchRecord.Db

    def parse_to_record(body, db_name) do
      document = document.db_name(db_name)
      document.body(body)
    end

    def create_document(db_name, body) do
      document = document.db_name(db_name)
      save!(db_name, body)
      document.body(body)
    end
end