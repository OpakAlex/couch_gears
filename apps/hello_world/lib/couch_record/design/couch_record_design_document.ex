defmodule CouchRecord.Design.Document do
  defmacro __using__(opts) do
    quote do
      defrecordp :document, unquote(opts)

      use CouchRecord.Base
      use CouchRecord.Design.Base
    end
  end
end

defmodule CouchRecord.Design.Document do
  use CouchRecord.Design.Document, [db_name: nil, body: nil, attrs: nil]
  use CouchRecord.Base.Document
end