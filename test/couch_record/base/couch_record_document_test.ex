Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.DocumentTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @document @db.get("medianet:album:100049")

  test :design? do
    assert @document.design? == false
  end

end