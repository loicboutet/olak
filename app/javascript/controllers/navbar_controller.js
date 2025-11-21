import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["menu", "menuButton", "menuIcon", "closeIcon"]

  connect() {
    // Initialize menu as hidden on mobile
    this.menuTarget.classList.add("hidden")
  }

  toggle() {
    const isHidden = this.menuTarget.classList.contains("hidden")
    
    if (isHidden) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    // Show menu
    this.menuTarget.classList.remove("hidden")
    
    // Update button icon if icons are present
    if (this.hasMenuIconTarget && this.hasCloseIconTarget) {
      this.menuIconTarget.classList.add("hidden")
      this.closeIconTarget.classList.remove("hidden")
    }
    
    // Update ARIA attributes
    this.menuButtonTarget.setAttribute("aria-expanded", "true")
  }

  close() {
    // Hide menu
    this.menuTarget.classList.add("hidden")
    
    // Update button icon if icons are present
    if (this.hasMenuIconTarget && this.hasCloseIconTarget) {
      this.menuIconTarget.classList.remove("hidden")
      this.closeIconTarget.classList.add("hidden")
    }
    
    // Update ARIA attributes
    this.menuButtonTarget.setAttribute("aria-expanded", "false")
  }

  // Close menu when clicking outside
  closeOnClickOutside(event) {
    if (!this.element.contains(event.target) && !this.menuTarget.classList.contains("hidden")) {
      this.close()
    }
  }

  // Close menu on escape key
  handleKeydown(event) {
    if (event.key === "Escape" && !this.menuTarget.classList.contains("hidden")) {
      this.close()
      this.menuButtonTarget.focus()
    }
  }

  disconnect() {
    // Cleanup if needed
  }
}