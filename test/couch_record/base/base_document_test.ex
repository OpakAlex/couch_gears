Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.DocumentTest do
  use ExUnit.Case, async: false

  test :parse_to_record do
    record = CouchRecord.Document.parse_to_record([{"a",1}, {"b", 2}], "db")
    assert record.db_name == "db"
    assert record.attrs[:a] == 1

    record = CouchRecord.Document.parse_to_record([{"a",1}, {"b", 2}, {"c", {[{"d", 3}]}}], "db")
    assert record.db_name == "db"
    assert record.attrs[:c][:d] == 3
  end

  test :create_document do
    record = CouchRecord.Document.create_document([{"a",1}, {"b", 2}], "db")
    assert record.attrs[:a] == 1
  end

end