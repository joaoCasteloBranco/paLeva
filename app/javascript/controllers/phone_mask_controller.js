import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  connect() {
    this.format(); 
  }

  format() {
    const value = this.fieldTarget.value.replace(/\D/g, ""); 
    this.fieldTarget.value = this.applyMask(value); 
  }

  update() {
    const value = this.fieldTarget.value.replace(/\D/g, ""); 
    this.fieldTarget.value = this.applyMask(value); 
  }

  applyMask(value) {
    if (!value) return "";
    if (value.length <= 10) {
      return value.replace(/(\d{2})(\d{4})(\d{0,4})/, "($1) $2-$3").trim();
    } else {
      return value.replace(/(\d{2})(\d{5})(\d{0,4})/, "($1) $2-$3").trim();
    }
  }

  clean() {
    this.fieldTarget.value = this.fieldTarget.value.replace(/\D/g, ""); 
  }
}
