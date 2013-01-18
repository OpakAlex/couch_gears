Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.Db.Test do
  use ExUnit.Case, async: false
  @db CouchRecord.Db.new("labeled")

  test :get_db_name do
    assert @db.db_name == "labeled"
  end

  test :exist? do
    assert CouchRecord.Db.db_exist?("labeled") == true
    assert CouchRecord.Db.new("labeled").exist? == true
  end

end
