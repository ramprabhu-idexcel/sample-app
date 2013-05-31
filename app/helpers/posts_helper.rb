module PostsHelper
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end

  def join_names(post)
  	post.user.first_name + post.user.last_name
  end

end

