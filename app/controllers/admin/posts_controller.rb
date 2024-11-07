# frozen_string_literal: true

class Admin::PostsController<ApplicationController
  def index
    respond_to do |format|
      format.html
      format.zip {respond_with_zip }
    end

  end

  def create
    if params[:archive].present?
      PostLoadService.call(params[:archive])
    end
  end

  private
  def respond_with_zip
    compressed_file_zip =  Zip::OutputStream.write_buffer do |zos|
      Post.order(created_at: :desc).all.each do |post|
        zos.put_next_entry "post_#{post.id}.xlsx"
        zos.print render_to_string(
                    layout: false,
                    handlers: [:axlsx],
                    formats: [:xlsx],
                    template: "admin/posts/post",
                    locals: { post: post }
                  )
      end
    end
    compressed_file_zip.rewind
    send_data compressed_file_zip.read, filename: 'posts.zip'
  end
end
