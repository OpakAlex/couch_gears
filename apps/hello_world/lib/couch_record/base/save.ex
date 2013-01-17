defmodule CouchRecord.Base.Save do
    defmacro __using__([]) do
      quote do

        def save!(rec) do
          case rec.save do
            false -> raise SaveError
            _ -> true
          end
        end

        def save(rec) do
          rec = apply_changes(rec)
          case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
            :ok -> rec
            _ -> false
          end
        end

        defp apply_changes(rec) do
          rec.body(to_list_binary(rec.attrs))
        end

      end
    end
end