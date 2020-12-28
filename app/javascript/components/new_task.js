const plus = document.querySelector(".fa-plus");
const newCard = document.querySelector(".new-card")

const showNew = () => {
if (plus) {
    plus.addEventListener('click', () => {
      newCard.classList.toggle("d-none");
      plus.classList.toggle("tranform-open")
    })
  }
}
  
export { showNew };