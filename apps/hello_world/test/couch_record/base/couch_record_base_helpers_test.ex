Code.require_file "../../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.HelpersTest do
  use ExUnit.Case, async: false

  test :key_to_atom do
    assert CouchRecord.Base.Helpers.key_to_atom(["_id","_rev"]) == [:_rev,:_id]
  end

  test :to_atom do
    assert CouchRecord.Base.Helpers.to_atom("test") == :test
    assert CouchRecord.Base.Helpers.to_atom(:test) == :test
  end

end
