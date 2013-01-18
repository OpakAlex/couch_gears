defmodule CouchRecord.Document do
  @moduledoc """
  This is base module for works with document from couchdb
  Use simple record for this
  """
  defmacro __using__(opts) do
    quote do
      defrecordp :document, unquote(opts)

      import CouchRecord.Base.Common
      use CouchRecord.Base
    end
  end
end


defmodule CouchRecord.Document do
  use CouchRecord.Document, [db_name: nil, body: nil, attrs: nil]

  use CouchRecord.Base.Document
end