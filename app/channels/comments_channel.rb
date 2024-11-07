class CommentsChannel < ApplicationCable::Channel
  def subscribed
    # Перевіряємо, чи надано post_id перед підпискою
    #  pry
    if params[:post_id].present?

      stream_from "comments:post_#{ params[:post_id]}"
    else
      reject
    end

  end

  def unsubscribed
  end

  def receive(data)
    logger.info "Received data: #{data}"
  end
end
