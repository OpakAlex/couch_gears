Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecordDesignShowTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("test_db")
  @desing_document @db.get("_design/tracks")

  test :shows do
    assert @desing_document.shows ==  [:two,:one]
  end

end