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
    assert @document._id == "medianet:album:100049"
  end

  test :methods do
    assert @document.__methods__.ids == "ids"
  end

  test :attributes do
     assert @document.__methods__._id(@document._id) == "medianet:album:100049"
  end

  test :has_one do
    assert @document.__methods__.has_one(@document.artist_uri)._id == "medianet:artist:6079"
  end

end