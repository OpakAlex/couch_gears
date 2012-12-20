defmodule ActiveResource.CouchDocument do
  use ActiveResource.CouchDocumentExtend, [db_name: nil, body: nil]

  defdelegate get(db_name, id), to: ActiveResource.Couch
  defdelegate save_to_db(db_name, body), to: ActiveResource.Couch

  def parse_to_record(body, db_name) do
    document = document.db_name(db_name)
    document.body(body)
  end

  def create_document(db_name, body) do
    document = document.db_name(db_name)
    save_to_db(db_name, body)
    document.body(body)
  end

end