Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecordDesignViewTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @desing_document @db.get("_design/tracks")

  test :views do
    assert @desing_document.views ==  [:any,:all]
  end
end