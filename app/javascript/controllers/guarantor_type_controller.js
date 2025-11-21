import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guarantor-type"
export default class extends Controller {
  static targets = ["visaleForm", "physicalForm"]

  connect() {
    // Initialize: show Visale form by default
    this.showVisale()
  }

  toggleForm(event) {
    const selectedType = event.target.value
    
    if (selectedType === "visale") {
      this.showVisale()
    } else if (selectedType === "physical") {
      this.showPhysical()
    }
  }

  showVisale() {
    this.visaleFormTarget.classList.remove("hidden")
    this.physicalFormTarget.classList.add("hidden")
  }

  showPhysical() {
    this.visaleFormTarget.classList.add("hidden")
    this.physicalFormTarget.classList.remove("hidden")
  }
}