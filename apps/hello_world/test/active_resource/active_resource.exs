Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule ActiveResourceTest do
  use ExUnit.Case, async: false

  @document ActiveResource.CouchDocument.get("labeled", "medianet:album:100049")

  test :set_db_name do
    assert @document.db_name == "labeled"
  end

  test :find_by_id do
    assert @document.attrs[:_id] == "medianet:album:100049"
  end

  test :has_field do
    assert @document.has_field?(:artist) == true
  end

  test :create_field do
    new_document = @document.create_field([test_field: "test"])
    assert new_document.attrs[:test_field] == "test"

    new_document = new_document.create_field([test: "a-test"])
    assert new_document.attrs[:test] == "a-test"
    assert new_document.attrs[:test_field] == "test"
  end

  test :update_field do
    update_doc = @document.update_field([type: "test_update"])
    assert update_doc.attrs[:type] == "test_update"
  end

  test :delete_field do
    assert @document.has_field?(:type) == true
    update_doc = @document.delete_field(:type)
    assert update_doc.has_field?(:type) == false
  end

  test :rename_field do
    update_doc = @document.rename_field(:type, :new_type)
    assert update_doc.attrs[:new_type] == "album"
  end

  test :with_fields do
    assert @document.fields_to_json([:_id, :_rev, :type]) == {[{"_id", "medianet:album:100049"},{"_rev", "2-15b8b3f4238233b35136c35b7db049e7"}, {"type", "album"}]}
    assert @document.fields_to_json() == {@document.body}
  end

  test :without_fields do
    assert @document.without_fields_to_json([:title, :genre, :label, :duration, :release_date, :total_tracks, :last_updated, :artist, :artist_id, :artist_uri, :_attachments]) == {[{"_id", "medianet:album:100049"}, {"_rev", "2-15b8b3f4238233b35136c35b7db049e7"}, {"type", "album"}]}
  end

  test :to_json do
    assert @document.to_json() == {@document.body}
  end

end