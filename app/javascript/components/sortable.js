import Sortable from "sortablejs";

const todoList = document.getElementById("todo-draggable");
const inprogressList = document.getElementById("inprogress-draggable");
const doneList = document.getElementById("done-draggable");
const csrfToken = document.querySelector("[name='csrf-token']").content;

  const initSortable = () => {
    // token to authorize CSRF with fetch

    var options = {
      group: "share",
      animation: 100,
      onEnd: (evt) => {
        fetch("/move_task", {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": csrfToken, // Set the token
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            // params with id of the task
            id: evt.item.dataset.id,
            // give the name of the column where the task is added
            status: evt.to.className,
            // allows to store the position of the task in the column
            position: evt.newIndex,
          }),
        });
      },
    };

    Sortable.create(todoList, options);
    Sortable.create(inprogressList, options);
    Sortable.create(doneList, options);
  };

export { initSortable };
