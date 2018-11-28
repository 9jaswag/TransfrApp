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
        progress.className = "progress-bar progress-bar-striped progress-bar-animated bg-success";
        progress.id = `direct-upload-progress-${index + 1}`;
        progress.dataset.filename = fileName;
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
  const { progress, file } = event.detail;
  const progressElement = document.querySelectorAll(`[data-filename='${file.name}']`)[0];
  if (progressElement) {
    progressElement.style.width = `${progress}%`;
    progressElement.firstElementChild.style.color = "white";
  }
});

addEventListener("direct-upload:error", event => {
  event.preventDefault();
  const { id, error } = event.detail;
  const element = document.getElementById(`direct-upload-${id}`);
  element.classList.add("direct-upload--error");
  element.setAttribute("title", error);
});
