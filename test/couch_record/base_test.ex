Code.require_file "../test_helper.exs", __FILE__

defmodule CouchRecord.Base.Test do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("test_db")
  @document @db.get("test_doc_id")

  test :set_db_name do
    assert @document.db_name == "test_db"
  end

  test :find_id do
    assert @document.attrs[:_id] == "test_doc_id"
  end

  test :has_field do
    assert @document.attr?(:artist) == true
  end

  test :create do
    new_document = @document.put(:test_field, "test")
    assert new_document.attrs[:test_field] == "test"

    new_document = new_document.put(:test, "a-test")
    assert new_document.attrs[:test] == "a-test"
    assert new_document.attrs[:test_field] == "test"
  end

  test :update do
    update_doc = @document.put("type", "test_update")
    assert update_doc.attrs[:type] == "test_update"
  end

  test :remove do
    assert @document.attr?(:type) == true
    update_doc = @document.remove("type")
    assert update_doc.attr?(:type) == false
  end

  test :rename do
    update_doc = @document.rename(:type, :new_type)
    assert update_doc.attrs[:new_type] == "album"
  end

end