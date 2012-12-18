defmodule ActiveResource.CouchDocument do
  use ActiveResource.CouchDocumentExtend, [db_name: nil, body: nil]

  defdelegate get(db_name, id), to: ActiveResource.Db
  defdelegate save_to_db(db_name, body), to: ActiveResource.Db

  def parse_to_record(body, db_name) do
    document = document.db_name(db_name)
    document.body(body)
  end

end