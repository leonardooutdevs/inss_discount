import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "zipcode",
    "state",
    "city",
    "address",
    "number",
    "complement",
    "neighborhood"
  ]

  search(e) {
      e.preventDefault();

      fetch(`/addresses/search?zip_code=${this.zipcodeTarget.value}`)
          .then(response => response.json())
          .then((data) => {
              const citySelect = this.cityTarget
              const city_option = document.createElement('option')
              city_option.value = data.city_id
              city_option.text = data.city
              citySelect.appendChild(city_option)
              citySelect.value = data.city_id

              const stateSelect = this.stateTarget
              const state_option = document.createElement('option')
              state_option.value = data.state_id
              state_option.text = data.state
              stateSelect.appendChild(state_option)
              stateSelect.value = data.state_id


              this.addressTarget.value = data.address
              this.complementTarget.value = data.complement
              this.neighborhoodTarget.value = data.neighborhood
          })
  }

  searchCities(e) {
    e.preventDefault();

    this.cityTarget.innerHTML = '';

    fetch(`/cities.json?q[state_id_eq]=${this.stateTarget.value}&per=9999`)
        .then(response => response.json())
        .then((data) => {
            data.forEach(city => {
                let option = document.createElement('option');
                option.value = city.id;
                option.text = city.name;
                this.cityTarget.appendChild(option);
            });
        })
  }
}
