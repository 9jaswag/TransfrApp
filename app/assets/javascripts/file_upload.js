document.addEventListener("turbolinks:load", event => {
  const form = document.querySelector("#upload_files");
  const selectedFiles = document.querySelector("#selected-files");
  form.onchange = formEvent => {
    Object.values(formEvent.target.files)
      .map(file => file.name)
      .forEach(fileName => {
        let fileEntry = document.createElement('p');
        fileEntry.className = 'selected-file';
        fileEntry.innerHTML = fileName;
        selectedFiles.appendChild(fileEntry);
      });
  };
});
