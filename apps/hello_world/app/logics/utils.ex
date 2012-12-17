defmodule CouchGears.AppUtils do
  def get_doc_id_from_doc(id, db_name) do
    doc = ActiveResource.find(db_name, id)
    doc.__methods__._id(doc)
    "w1q"
  end
end