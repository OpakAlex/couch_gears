defmodule ActiveResource.DesignDocument do
  import ActiveResource.CouchDocument

  defdelegate get(db_name, id), to: ActiveResource.Couch
  defdelegate save_to_db(db_name, body), to: ActiveResource.Couch

end