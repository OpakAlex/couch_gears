defmodule CouchRecord.Design.CRUD do
  @moduledoc """
  CRUD functions for design document
  """
  defmacro __using__([]) do
    quote do

      def put(type, name, value, rec) do
        type = plural(:atom, type)
        unless rec.exist?(type) do
          rec = rec.put(type, HashDict.new([]))
        end
        put_design(type, name, value, rec)
      end

      def remove(type, name, rec) do
        type = plural(:atom, type)
        design_attrs = rec.attrs[type]
        design_attrs = Dict.delete(design_attrs, to_atom(name))
        rec.attrs(Dict.put(rec.attrs, type, design_attrs))
      end

      def rename(type, name, new_name, rec) do
        plural = plural(:atom, type)
        value = rec.attrs[plural][name]
        rec = rec.remove(type, name)
        rec.put(type, new_name, value)
      end

      #private
      defp put_design(type, name, value, rec) do
        design_attrs = Dict.put(rec.attrs[type], to_atom(name), {[value]})
        rec.attrs(Dict.put(rec.attrs, type, design_attrs))
      end

    end
  end
end