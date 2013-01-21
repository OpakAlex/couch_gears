Code.require_file "../test_helper.exs", __FILE__

defmodule CouchRecord.Db.Test do
  use ExUnit.Case, async: false
  @db CouchRecord.Db.new("test_db")

  test :get_db_name do
    assert @db.db_name == "test_db"
  end

  test :exist? do
    assert CouchRecord.Db.db_exist?("test_db") == true
    assert CouchRecord.Db.new("test_db").exist? == true
  end

end
