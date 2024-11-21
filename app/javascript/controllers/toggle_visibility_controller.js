import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable", "checkbox"];

  connect() {
    this.update(); 
  }

  update() {
    if (this.checkboxTarget.checked) {
      this.show();
    } else {
      this.hide();
    }
  }

  show() {
    this.toggleableTargets.forEach((target) => {
      target.classList.remove("hidden");
    });
  }

  hide() {
    this.toggleableTargets.forEach((target) => {
      target.classList.add("hidden");
    });
  }
}
