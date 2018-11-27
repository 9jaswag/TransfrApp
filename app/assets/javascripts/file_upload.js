document.addEventListener("turbolinks:load", event => {
  const form = document.querySelector("#upload_files");
  const selectedFiles = document.querySelector("#selected-files");
  form.onchange = formEvent => {
    Object.values(formEvent.target.files)
      .map(file => file.name)
      .forEach((fileName, index) => {
        let fileEntry = document.createElement("div");
        fileEntry.className = "progress";
        fileEntry.id = `direct-upload-${index + 1}`;
        let progress = document.createElement("div");
        progress.className = "progress-bar bg-success";
        progress.id = `direct-upload-progress-${index + 1}`;
        progress.style.width = "0%";
        let fileEntrySpan = document.createElement("span");
        fileEntrySpan.innerHTML = fileName;
        fileEntrySpan.style.color = "black";
        progress.appendChild(fileEntrySpan);
        fileEntry.appendChild(progress);
        selectedFiles.appendChild(fileEntry);
      });
  };
});

addEventListener("direct-upload:progress", event => {
  const { id, progress } = event.detail;
  const progressElement = document.getElementById(
    `direct-upload-progress-${id}`
  );
  progressElement.style.width = `${progress}%`;
  progressElement.firstElementChild.style.color = "white";
});

addEventListener("direct-upload:error", event => {
  event.preventDefault();
  const { id, error } = event.detail;
  const element = document.getElementById(`direct-upload-${id}`);
  element.classList.add("direct-upload--error");
  element.setAttribute("title", error);
});
