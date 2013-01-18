Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.SaveTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @document @db.get("medianet:album:100049")

  test :save! do
    assert @document.save! == true
  end

  # test :save_with_error do
    # assert @document.save == false
  # end

  test :save do
    assert @document.save.attrs == @document.attrs
  end
end