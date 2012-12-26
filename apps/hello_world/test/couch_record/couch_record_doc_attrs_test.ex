Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule CouchRecord.DocAttrsTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @document @db.get("medianet:album:100049")

  test :_id do
    assert @document._id == "medianet:album:100049"
  end

  test :_rev do
    assert @document._rev == "2-15b8b3f4238233b35136c35b7db049e7"
  end

end