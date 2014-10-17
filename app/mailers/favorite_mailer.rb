class FavoriteMailer < ActionMailer::Base
  default from: "psb.sambath@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@sambath-bloccit.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@sambath-bloccit.com>"
    headers["References"] = "<post/#{post.id}@sambath-bloccit.com>"

    @user, @post, @comment = user, post, comment
    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
