Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule CouchRecord.JsonMethodsTest do
  use ExUnit.Case, async: false
  @db CouchRecord.Db.new("labeled")
  @document @db.get("medianet:album:100049")


  test :with_attrs do
    assert @document.attrs_to_json([:_id, :_rev, :type]) == {[{"_id", "medianet:album:100049"},{"_rev", "2-15b8b3f4238233b35136c35b7db049e7"}, {"type", "album"}]}
  end

  test :without_fields do
    assert @document.without_attrs_to_json([:title, :genre, :label, :duration, :release_date, :total_tracks, :last_updated, :artist, :artist_id, :artist_uri, :_attachments]) == {[{"_id", "medianet:album:100049"}, {"type", "album"}, {"_rev", "2-15b8b3f4238233b35136c35b7db049e7"}]}
  end

  test :to_json do
    assert @document.to_json() == {@document.body}
  end

end