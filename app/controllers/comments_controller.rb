class CommentsController < ApplicationController
  before_action :set_post, only: %i[create]

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      comment_html = render_to_string(
        partial: 'comments/comment',
        formats: [:html],
        locals: { comment: @comment }
      )

      CommentsChannel.broadcast_to("post_#{@post.id}", {
        comment: comment_html,
        postId: @post.id
      })


      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace( "new_comment", partial: "comments/form",
                                                     locals: { comment: Comment.new, post: @post })
        }
        format.html
      end
    else
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
