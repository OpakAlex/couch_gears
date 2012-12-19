defmodule ActiveResource.DesignDocumentExtend do
  defmacro __using__(opts) do
    quote do
      def has_view?(rec) do
        rec.has_field?(:views)
      end

      def has_view?(view, rec) do
        if rec.has_view? do
          case get_value_from_json(view, get_all_views(rec)) do
            :not_found -> false
            _ -> true
          end
        else
          false
        end
      end

      def design?(rec) do
        Regex.match?(%r/^_design/, rec.attrs[:_id])
      end

      def name(rec) do
        Regex.replace(%r(_design/), rec.attrs[:_id], '')
      end

      def views(rec) do
        key_to_atom(Keyword.keys(get_all_views(rec)))
      end

      def view_body(view, rec) do
        {body} = get_value_from_json(view, get_all_views(rec))
        body
      end

      def create_view(view, value, rec) do
        unless rec.has_view? do
          rec = rec.create_field([views: {[]}])
        end
        view_body = get_all_views(rec)
        view_body = view_body ++ [{to_binary(view), {[value]}}]
        new_body = [{"views", {view_body}}] ++ remove_views(rec)
        save(new_body, rec)
      end

      def update_view(view, value, rec) do
        view_body = remove_view(view, rec)
        view_body = view_body ++ [{to_binary(view), {[value]}}]
        new_body = [{"views", {view_body}}] ++ remove_views(rec)
        save(new_body, rec)
      end

      def delete_view(view, rec) do
        view_body = remove_view(view, rec)
        new_body = [{"views", {view_body}}] ++ remove_views(rec)
        save(new_body, rec)
      end

      def rename_view(view, new_name, rec) do
        [view_body | t] = rec.view_body(view)
        rec = rec.delete_view(view)
        rec.create_view(new_name, view_body)
      end


      #private

      defp remove_view(key, rec) do
        List.keydelete(get_all_views(rec), to_binary(key), 0)
      end

      defp remove_views(rec) do
        List.keydelete(rec.body, to_binary(:views), 0)
      end

      defp get_all_views(rec) do
        {views_list} = rec.attrs[:views]
        views_list
      end

    end
  end
end