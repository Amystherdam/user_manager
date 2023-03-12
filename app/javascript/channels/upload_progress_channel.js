import consumer from "./consumer";

document.addEventListener("DOMContentLoaded", () => {
  let channelKey = document.querySelector("input#user_channel_key").value;

  consumer.subscriptions.create(
    {
      channel: "UploadProgressChannel",
      channelKey: channelKey,
    },
    {
      connected() {},

      received(data) {
        let spreedsheetFileLabel = document.querySelector("label#file_label");
        let spreedsheetFileField = document.querySelector("input#user_file");
        if (data.progress === 100) {
          spreedsheetFileField.value = null;
          spreedsheetFileLabel.innerHTML = "Loaded";
          setTimeout(() => {
            spreedsheetFileLabel.innerHTML = "Upload";
          }, 2000);
        } else {
          spreedsheetFileLabel.innerHTML = `${data.progress}%`;
        }
      },
    }
  );
});
