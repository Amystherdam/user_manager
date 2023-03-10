import consumer from "./consumer";

consumer.subscriptions.create("UserChannel", {
  connected() {
    // ...
  },

  disconnected() {
    // ...
  },

  received(data) {
    document.getElementById(
      "total-user-count"
    ).innerHTML = `${data.total_user_count} usuários`;
    document.getElementById(
      "admin-user-count"
    ).innerHTML = `${data.admin_user_count} administradores`;
    document.getElementById(
      "common-user-count"
    ).innerHTML = `${data.common_user_count} comuns`;
  },
});
