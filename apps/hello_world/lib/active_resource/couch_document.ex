# path = File.expand_path("../couch_document_add.ex", __FILE__)
# Code.load_file path

defmodule CouchDocument do
  use CouchDocumentAdd, [db_name: nil]

  def parse_to_record(body, db_name) do
    document = document.db_name(db_name)
    document.new(body)
  end

  defp get_value_from_json(field, body) do
    :proplists.get_value(field, body, :nil)
  end
end