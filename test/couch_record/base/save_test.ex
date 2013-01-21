Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.SaveTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("test_db")
  @document @db.get("test_doc_id")

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