import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calculations"
export default class extends Controller {
  static targets = ["gross", "discount", "netSalary", "currentUser"]

  calculate() {
    let gross = this.grossTarget.value;
    let currentUserId = this.currentUserTarget.attributes['value'].value;

    fetch(`/proponents/calculate_discount?gross_salary=${gross}`)
      .then(response => {
        if (response.ok) {
          document.querySelector(`turbo-frame[id='net_salary_for_1']`).innerHTML =
            '<div class="spinner-border" role="status">' +
            '<span class="visually-hidden">Loading...</span>' +
            '</div>';
          document.querySelector(`turbo-frame[id='discount_for_1']`).innerHTML =
            '<div class="spinner-border" role="status">' +
            '<span class="visually-hidden">Loading...</span>' +
            '</div>';
        } else {
          document.querySelector(`turbo-frame[id='net_salary_for_${currentUserId}']`).innerHTML =
            '<div class="spinner-grow text-danger" role="status">' +
            '<span class="visually-hidden">Loading...</span>' +
            '</div>';
          document.querySelector(`turbo-frame[id='discount_for_${currentUserId}']`).innerHTML =
            '<div class="spinner-grow text-danger" role="status">' +
            '<span class="visually-hidden">Loading...</span>' +
            '</div>';
        }
      });
  }
}
