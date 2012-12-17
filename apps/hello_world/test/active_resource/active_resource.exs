Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule ActiveResourceTest do
  use ExUnit.Case, async: false
  @db ActiveResource.new("labeled")

  @document ActiveResourceTestHelper.find(@db.db_name(), "medianet:album:100049")

  test :set_db_name do
    assert @db.db_name() == "labeled"
  end

  test :find_by_id do
    assert @document.__methods__.field(:_id, @document) == "medianet:album:100049"
  end

  test :db_name do
    assert @document.__methods__.db_name == "labeled"
  end


  test :has_field do
    assert @document.__methods__.has_field?(:artist, @document) == true
  end

  test :create_field do
    new_document = @document.__methods__.create_field([test_field: "test"], @document)
    assert new_document.__methods__.field(:test_field, new_document) == "test"

    new_document = new_document.__methods__.create_field([test: "a-test"], new_document)
    assert new_document.__methods__.field(:test, new_document) == "a-test"
    assert new_document.__methods__.field(:test_field, new_document) == "test"
  end

  test :update_field do
     update_doc = @document.__methods__.update_field([type: "test_update"], @document)
     assert update_doc.__methods__.field(:type, update_doc) == "test_update"
  end

  test :delete_field do
    assert @document.__methods__.has_field?(:type, @document) == true
    update_doc = @document.__methods__.delete_field(:type, @document)
    assert update_doc.__methods__.has_field?(:type, update_doc) == false
  end

  test :rename_field do
    update_doc = @document.__methods__.rename_field(:type, :new_type, @document)
    assert update_doc.__methods__.field(:new_type, update_doc) == "album"
  end

  test :attributes do
     assert @document.__methods__._id(@document) == "medianet:album:100049"
     assert @document.__methods__.field(:type, @document) == "album"
     assert @document.__methods__._rev(@document) == "2-15b8b3f4238233b35136c35b7db049e7"
  end

  test :with_fields do
    assert @document.__methods__.with_fields([:_id, :_rev, :type], @document) == [{"_id", "medianet:album:100049"},{"_rev", "2-15b8b3f4238233b35136c35b7db049e7"}, {"type", "album"}]
    assert @document.__methods__.with_fields(@document) == @document.__attributes__
  end

  test :without_fields do
    assert @document.__methods__.without_fields([:title, :genre, :label, :duration, :release_date, :total_tracks, :last_updated, :artist, :artist_id, :artist_uri, :_attachments], @document) == [{"_rev", "2-15b8b3f4238233b35136c35b7db049e7"}, {"_id", "medianet:album:100049"}, {"type", "album"}]
  end

  test :to_json do
    assert @document.__methods__.to_json(@document) == {@document.__attributes__}
  end

end