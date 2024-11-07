import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["openingTime", "closingTime", "openCheckbox"];

  connect() {
    this.toggleTimeFields(); 
  }

  toggleTimeFields() {
    const isOpen = this.openCheckboxTarget.checked;
    this.openingTimeTarget.style.display = isOpen ? "block" : "none";  
    this.closingTimeTarget.style.display = isOpen ? "block" : "none"; 
  }
}
