import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  connect() {
    this.format();
  }

  format() {
    const value = this.fieldTarget.value.replace(/\D/g, "");
    if (value) {
      const formattedValue = (parseInt(value, 10) / 100).toFixed(2).replace(".", ",");
      this.fieldTarget.value = `R$ ${formattedValue}`;
    }
  }

  update() {
    const rawValue = this.fieldTarget.value.replace(/\D/g, "");
    const formattedValue = (parseInt(rawValue, 10) / 100).toFixed(2).replace(".", ",");
    this.fieldTarget.value = `R$ ${formattedValue}`;
  }

  clean() {
    const rawValue = this.fieldTarget.value.replace(/\D/g, ""); 
    this.fieldTarget.value = rawValue || "0"; 
  }
}
