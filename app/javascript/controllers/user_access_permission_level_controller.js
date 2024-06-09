// app/javascript/controllers/user_access_permission_level_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["permission"];

  hideColumn(event) {
    const button = event.currentTarget;
    const permissionElement = button.closest("[data-user-access-permission-level-target='permission']");
    if (permissionElement) {
      permissionElement.style.display = "none";
    }
  }
}
