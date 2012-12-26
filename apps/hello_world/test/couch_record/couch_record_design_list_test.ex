Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule CouchRecordDesignListTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @desing_document @db.get("_design/tracks")

  test :shows do
    assert @desing_document.lists ==  [:list2,:list1]
  end

end