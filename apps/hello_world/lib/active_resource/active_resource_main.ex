defmodule ActiveResource.DbSettings do
  defmacro __using__(opts) do
    quote do

      defrecordp :db_settings, [] ++ unquote(opts)

      def db_name(db_settings(db_name: db_name)) do
        db_name
      end

      def db_name(db_name, rec) do
        db_settings(rec, db_name: db_name)
      end
    end
  end
end

defmodule ActiveResource.Main do

  # Code.require_file "../utils.ex", __FILE__

  use ActiveResource.DbSettings, [db_name: ""]

  def new(db_name) do
    db_settings.db_name(db_name)
  end

  def find(db_name, id) do
    case is_binary(id) do
      true -> find_by_id(db_name, id)
      false -> :ok
    end
  end

  defp find_by_id(db_name, id) do
    ActiveResource.Utils.find(db_name, id)
  end

end
