import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="property-type"
export default class extends Controller {
  static targets = ["error"]

  connect() {
    this.selectedType = null
  }

  selectType(event) {
    // Store the selected property type
    this.selectedType = event.target.value
    
    // Hide error message if visible
    if (this.hasErrorTarget) {
      this.errorTarget.classList.add("hidden")
    }
  }

  submit(event) {
    event.preventDefault()
    
    // Validate that a property type is selected
    if (!this.selectedType) {
      this.showError()
      return
    }
    
    // Navigate to the appropriate step2 page based on selection
    const routes = {
      'apartment': '/mockups/owner/property_step2_apartment',
      'house': '/mockups/owner/property_step2_house',
      'room': '/mockups/owner/property_step2_room'
    }
    
    const targetRoute = routes[this.selectedType]
    if (targetRoute) {
      window.location.href = targetRoute
    }
  }

  showError() {
    if (this.hasErrorTarget) {
      this.errorTarget.classList.remove("hidden")
      // Scroll to error message
      this.errorTarget.scrollIntoView({ behavior: 'smooth', block: 'center' })
    }
  }
}