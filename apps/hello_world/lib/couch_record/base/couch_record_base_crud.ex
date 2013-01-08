defmodule CouchRecord.Base.CRUD do
  defmacro __using__([]) do
    quote do

      def put(key, value, rec) do
        rec = rec.attrs(Dict.put(rec.attrs, to_atom(key), value))
        apply_changes(rec)
      end

      def remove(key, rec) do
        rec = rec.attrs(Dict.delete(rec.attrs, to_atom(key)))
        apply_changes(rec)
      end

      def rename(name, new_name, rec) do
        value = rec.attrs[to_atom(name)]
        rec = rec.attrs(Dict.delete(rec.attrs, to_atom(name)))
        rec.put(to_atom(new_name), value)
      end

      def remove_document(rec) do
        rec.put(:_deleted, true)
      end

    end
  end
end