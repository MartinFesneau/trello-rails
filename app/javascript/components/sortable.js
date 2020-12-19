import Sortable from "sortablejs";

const todoList = document.getElementById("todo");
const inprogressList = document.getElementById("inprogress");
const doneList = document.getElementById("done");

const initSortable = () => {
  // token to authorize CSRF with fetch
  const csrfToken = document.querySelector("[name='csrf-token']").content;

    var options = {
      group: "share",
      animation: 100,
      onEnd: (evt) => {
        console.log(evt.newIndex)
        fetch("/move_task", {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": csrfToken, // Set the token
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            id: evt.item.dataset.id,  // params with id of the task
            status: evt.to.id, // give the name of the column where the task is added
            position: evt.newIndex, // allows to store the position of the task in the column
          }),
        });
      },
    };

    Sortable.create(todoList, options);
    Sortable.create(inprogressList, options);
    Sortable.create(doneList, options);
  };

export { initSortable };
