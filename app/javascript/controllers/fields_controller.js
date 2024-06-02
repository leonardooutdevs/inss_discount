import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  add(event) {
    event.preventDefault();
    if (this.element.querySelector('.nested-fields').classList.contains('unsaved')) {
      alert("Por favor, salve o registro atual antes de adicionar um novo.")
    }
    let time = new Date().getTime();
    let fields = event.target.dataset.fields.replace(/new_fields/g, time)
    event.target.insertAdjacentHTML('beforebegin', fields)
  }

  remove(event) {
    event.preventDefault();

    let element = event.target;
    let field = element.closest(".nested-fields");
    if (field.dataset.newRecord == "true") {
      field.remove();
    } else {
      field.querySelector("input[name$='[_destroy]']").value = 1;
      field.style.display = "none";
    }
  }
}
