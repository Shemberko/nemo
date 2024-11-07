import consumer from "./consumer"
document.addEventListener('DOMContentLoaded', () => {
  const postId = document.querySelector('#post').getAttribute('data-post-id');

  // Перевірка у вкладеному масиві subscriptions
  if (postId && !consumer.subscriptions.subscriptions.find(sub => sub.identifier === JSON.stringify({ channel: "CommentsChannel", post_id: postId }))) {
    consumer.subscriptions.create(
        { channel: "CommentsChannel", post_id: postId },
        {
          connected() {
            console.log("Connected to CommentsChannel for post:", postId);
          },
          disconnected() {
            console.log("Disconnected from CommentsChannel");
          },
          received(data) {
            console.log("Received data:", data);
            const commentsElement = document.getElementById(`comments_${data.postId}`);
            if (commentsElement) {
              commentsElement.insertAdjacentHTML('beforeend', data.comment);
            }
          }
        }
    );
  }
});
