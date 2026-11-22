module ApplicationHelper
  def app_icon(name, css_class: "icon")
    paths = {
      "grid" => '<rect x="3" y="3" width="7" height="7" rx="2"/><rect x="14" y="3" width="7" height="7" rx="2"/><rect x="3" y="14" width="7" height="7" rx="2"/><rect x="14" y="14" width="7" height="7" rx="2"/>',
      "plus" => '<path d="M12 5v14M5 12h14"/>',
      "check" => '<path d="m5 12 4 4L19 6"/>',
      "arrow" => '<path d="M5 12h14m-5-5 5 5-5 5"/>',
      "back" => '<path d="M19 12H5m5-5-5 5 5 5"/>',
      "clock" => '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
      "message" => '<path d="M21 11.5a8.5 8.5 0 0 1-8.5 8.5H4l-2 2v-9.5A8.5 8.5 0 0 1 10.5 4h2a8.5 8.5 0 0 1 8.5 7.5Z"/>',
      "edit" => '<path d="m15 5 4 4M4 20l4-1L20 7a2.8 2.8 0 0 0-4-4L4 15l-1 6Z"/>',
      "trash" => '<path d="M3 6h18M9 6V3h6v3M5 6l1 15h12l1-15M10 10v7m4-7v7"/>',
      "logout" => '<path d="M9 4H4v16h5m0-8h12m-4-4 4 4-4 4"/>',
      "lock" => '<rect x="5" y="10" width="14" height="11" rx="3"/><path d="M8 10V7a4 4 0 0 1 8 0v3m-4 5v2"/>',
      "spark" => '<path d="m12 3 2.5 6.5L21 12l-6.5 2.5L12 21l-2.5-6.5L3 12l6.5-2.5L12 3Z"/>'
    }
    content_tag(:svg, paths.fetch(name, paths["grid"]).html_safe,
      class: css_class, width: 18, height: 18, viewBox: "0 0 24 24", fill: "none", stroke: "currentColor",
      "stroke-width": "1.7", "stroke-linecap": "round", "stroke-linejoin": "round", "aria-hidden": "true")
  end
end
