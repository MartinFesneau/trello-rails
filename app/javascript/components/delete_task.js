const cards = document.querySelectorAll(".card")

const deleteTask = () => {
  if (cards) {
    cards.forEach((card) => {
      card.querySelector(".fa-trash").addEventListener("click", (event) => {
        card.classList.add("d-none")
      })
    })
  }
}
    
export { deleteTask }