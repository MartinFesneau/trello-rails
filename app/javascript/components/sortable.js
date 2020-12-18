import Sortable from "sortablejs";

const initSortable = () => {
  const todoList = document.getElementById("todo-draggable");
  const todoSortable = new Sortable(todoList, {
    group: "lists",
    onEnd: (evt) => {
      console.log({
              'this': this,
              'item': evt.item,
              'from': evt.from,
              'to': evt.to,
              'oldIndex': evt.oldIndex,
              'newIndex': evt.newIndex,
    });
  }
});




  const inprogressList = document.getElementById("inprogress-draggable");
  const inprogressSortable = new Sortable(inprogressList, {
    group: "lists"
  });

  const doneList = document.getElementById("done-draggable");
  const doneSortable = new Sortable(doneList, {
    group: "lists"
  });



  // var options = {
  //   group: 'share',
  //   animation: 100,
  // };
  
  // var events = [
  //   'onEnd'
  // ].forEach(function (name) {
  //   options[name] = function (evt) {
  //     console.log({
  //       'event': name,
  //       'this': this,
  //       'item': evt.item,
  //       'from': evt.from,
  //       'to': evt.to,
  //       'oldIndex': evt.oldIndex,
  //       'newIndex': evt.newIndex,
  //       'status': todoList.dataset.status
  //     });
  //   };
  // });

  // Sortable.create(todoList, options);
  // Sortable.create(inprogressList, options);
  // Sortable.create(doneList, options);

}

export { initSortable }