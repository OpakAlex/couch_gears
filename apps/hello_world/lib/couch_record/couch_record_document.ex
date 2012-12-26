defmodule CouchRecord.Document do
  defmacro __using__(opts) do
    quote do
      defrecordp :document, unquote(opts)
      use CouchRecord.Base
    end
  end
end


defmodule CouchRecord.Document do
  use CouchRecord.Document, [db_name: nil, body: nil, attrs: nil]

  use CouchRecord.Base.DocumentCommon
end