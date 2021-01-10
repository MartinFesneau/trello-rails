import Sortable from "sortablejs";

const initSortable = () => {
  const todoList = document.getElementById("todo");
  const inprogressList = document.getElementById("inprogress");
  const doneList = document.getElementById("done");
  // token to authorize CSRF with fetch
  if (todoList) {
    console.log(todoList)

    const csrfToken = document.querySelector("[name='csrf-token']").content;
    
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
            id: evt.item.dataset.id,  // params with id of the task
            status: evt.to.id, // give the name of the column where the task is added
            position: evt.newIndex + 1, // allows to store the position of the task in the column + 1 as it is an index
          }),
        });
      },
    };
    
    Sortable.create(todoList, options);
    Sortable.create(inprogressList, options);
    Sortable.create(doneList, options);
    console.log('mes zones sortables sont crées')
  };
}

export { initSortable };
