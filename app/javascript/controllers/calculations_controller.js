import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calculations"
export default class extends Controller {
  static targets = ["gross", "discount", "netSalary"]

  calculate() {
    console.log(this.grossTarget.value)

    let gross = this.grossTarget.value;

    fetch(`/proponents/calculate_discount?gross_salary=${gross}`)
      .then(response => response.json())
      .then(data => {
        this.discountTarget.textContent = toCurrency(data['data'][0]);
        this.netSalaryTarget.textContent = toCurrency(data['data'][1]);
    });
  }
}

function toCurrency(value, options = { symbol: 'R$ ', decimalSeparator: ',', thousandsSeparator: '.' }){
  let number = parseFloat(value).toFixed(2);
  number = number.replace('.', options.decimalSeparator);
  let parts = number.split(options.decimalSeparator);
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, options.thousandsSeparator);
  return options.symbol + parts.join(options.decimalSeparator);
}
