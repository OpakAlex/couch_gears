ExUnit.start
Code.require_file "../../../../../lib/utils/active_resource/active_resource.ex", __FILE__
defmodule UtilsTest do

  use ExUnit.Case, async: false
  @db ActiveResource.new("labeled")
  @document ActiveResource.find(@db.db_name(), "medianet:album:100049")

  test :set_db_name do
    assert @db.db_name() == "labeled"
  end

  test :find_by_id do
    assert @document.__methods__.field(:_id, @document) == "medianet:album:100049"
  end

  test :methods do
    assert @document.__methods__.ids == "ids"
  end

  test :db_name do
    assert @document.__methods__.db_name == "labeled"
  end


  test :has_field do
    assert @document.__methods__.has_field?(:artist, @document) == true
  end

  test :add_field do
    new_document = @document.__methods__.add_field([test_field: "test"], @document)
    assert new_document.__methods__.field(:test_field, new_document) == "test"

    new_document = new_document.__methods__.add_field([test: "a-test"], new_document)
    assert new_document.__methods__.field(:test, new_document) == "a-test"
    assert new_document.__methods__.field(:test_field, new_document) == "test"
  end

  test :update_field do
    # update_doc = @document.__methods__.update_field([type: "test_update"], @document)

  end

  test :has_one do
    has_one_doc = @document.__methods__.has_one(:artist_uri, @document)
    assert has_one_doc.__methods__.field(:_id, has_one_doc) == "medianet:artist:6079"
  end

  test :attributes do
     assert @document.__methods__._id(@document) == "medianet:album:100049"
  end


end