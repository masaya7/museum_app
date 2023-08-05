module PostsHelper
  def render_empathy_icon(emotion, post_id)
    case emotion
    when :happy
      '😀'
    when :sad
      '😢'
    when :love
      '😍'
    when :anger
      '😤'
    else
      ''
    end
  end
end
