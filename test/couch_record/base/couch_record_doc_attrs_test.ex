Code.require_file "../../test_helper.exs", __FILE__

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

  test :attrs do
    assert @document.attrs == HashDict.new([total_tracks: 14, _attachments: HashDict.new(["track.preview.mp3": HashDict.new(
                                [stub: true, revpos: 6, digest: "md5-hX1sGYK4WZoc6spoD1wf0w==", content_type: "audio/mpeg",
                                 length: 486703])]), _id: "medianet:album:100049", last_updated: 1348551435, artist: "Christopher Parkening",
                                 artist_id: "6079", type: "album", title: "Simple Gifts", genre: "Classical/Opera",
                                 release_date: "10-25-1990", _rev: "2-15b8b3f4238233b35136c35b7db049e7", artist_uri: "medianet:artist:6079",
                                 label: "Capitol Catalog", duration: "38:05"])
  end

  test :is_attr? do
    assert @document.attr?(:total_tracks) == true
    assert @document.attr?(:total_tracks___) == false
  end

end