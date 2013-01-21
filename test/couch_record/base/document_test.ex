Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.DocumentTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("test_db")
  @document @db.get("test_doc_id")

  test :design? do
    assert @document.design? == false
  end

end