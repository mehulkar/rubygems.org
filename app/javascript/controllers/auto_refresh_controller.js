/* A controller that, when loaded, causes the page to refresh periodically */

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    interval: { type: Number, default: 5000 }
  }

  connect() {
    this.refresh()
  }

  refresh() {
    setTimeout(() => {
      window.location.reload()
    }, this.intervalValue)
  }
}
