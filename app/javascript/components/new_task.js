
const initNewTask = () => {
  const submitButton = document.querySelector("input[type=submit]");
  const csrfToken = document.querySelector("[name='csrf-token']").content;
  submitButton.addEventListener("click", (event) => {
    const input = document.getElementById("task_name").value;
    event.preventDefault()
    console.log(input)
    fetch("/create", {
      method: "POST",
      headers: {
      "X-CSRF-Token": csrfToken, // Set the token
      "Content-Type": "application/json",
    },
      body: JSON.stringify({
        name: input
    })
  })
})
}

export { initNewTask } 