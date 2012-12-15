defmodule CouchDocumentAdd do
  defmacro __using__(opts) do
    quote do
      defrecordp :document, unquote(opts)

      def _new(proplist, rec) do
        proplist = proplist ++ [{:__methods__, rec}]
        defrecord Document, proplist
        Document.new(proplist)
      end

      def ids(rec) do
        "ids"
      end

      def _id(id, rec) do
        id
      end

      def has_one(id, rec) do
        Utils.find("labeled", id)
      end

    end
  end
end


defmodule CouchDocument do

  def key_to_atom([]) do
    []
  end

  def key_to_atom([h|t]) do
    key_to_atom(h) ++ key_to_atom(t)
  end

  def key_to_atom(key) do
    [binary_to_atom(key, :utf8)]
  end

  def parse_to_record(body) do
    name = module_name(body)
    Code.eval("defmodule #{name} do use CouchDocumentAdd, []; def new() do document end end")
    {module, _ } = Code.eval("#{name}")
    proplist = proplist(body)
    document = module.new()
    document._new(proplist)
  end

  defp keys(body) do
    List.flatten(key_to_atom(:proplists.get_keys(body)))
  end


  defp proplist(body) do
    Enum.map keys(body), fn(el) ->
      {el, get_value_from_json(to_binary(el), body)}
    end
  end

  defp get_value_from_json(field, body) do
    :proplists.get_value(field, body, :nil)
  end

  defp module_name(body) do
    Mix.Utils.camelize(Regex.replace(%r/:/, get_value_from_json("_id", body), "_"))
  end

end


defmodule Utils do
  import CouchDocument

  # def find(db_name, id) do
  #   case :couch_db.open_doc(get_db(db_name), id) do
  #     {ok, doc} ->
  #       body = :couch_doc.to_json_obj(doc, [])
  #     _ -> :not_found
  #   end
  # end

  def find(db_name, id) do
    if id == "medianet:album:100049" do
      {body} = {[{<<"_id">>,<<"medianet:album:100049">>},
             {<<"_rev">>,<<"2-15b8b3f4238233b35136c35b7db049e7">>},
             {<<"type">>,<<"album">>},
             {<<"title">>,<<"Simple Gifts">>},
             {<<"genre">>,<<"Classical/Opera">>},
             {<<"label">>,<<"Capitol Catalog">>},
             {<<"duration">>,<<"38:05">>},
             {<<"release_date">>,<<"10-25-1990">>},
             {<<"total_tracks">>,14},
             {<<"last_updated">>,1348551435},
             {<<"artist">>,<<"Christopher Parkening">>},
             {<<"artist_id">>,<<"6079">>},
             {<<"artist_uri">>,<<"medianet:artist:6079">>}]}
        parse_to_record(body)
    else
      {body} = {[{<<"_id">>,<<"medianet:artist:6079">>},
             {<<"_rev">>,<<"2-15b8b3f4238233b35136c35b7db049e7">>},
             {<<"type">>,<<"artist">>},
             {<<"name">>,<<"Artist Test">>}]}
      parse_to_record(body)
    end

  end

  defp get_db(db_name) do
    {_, db} = :couch_db.open_int(to_binary(db_name), [])
    db
  end
end