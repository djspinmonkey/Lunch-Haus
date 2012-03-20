module UsersHelper

  def gravatar_url(user)
    # TODO: custom default avatar?
    gravatar_hash = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_hash}"
  end

end
