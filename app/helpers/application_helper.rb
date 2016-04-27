module ApplicationHelper
  def active(hash={})
    if controller_name == hash[:controller] && current_page?( pj_kind: hash[:pj_kind])
      "class='active'".html_safe
    end
  end
  
  def show_video(hash={})
    if !hash[:data].blank?
      return embed(hash[:data])
    else
      return "--"
    end
  end
end
