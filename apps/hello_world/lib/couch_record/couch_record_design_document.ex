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

    use CouchRecord.DocumentCommon
end