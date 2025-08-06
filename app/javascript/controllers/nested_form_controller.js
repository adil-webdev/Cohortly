import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {

  static targets = ["wrapper", "template"]
  static values = { fieldFor: String  }

  connect() {
  }

  add(event) {
    event.preventDefault();
    let fields = document.getElementsByClassName(this.templateTarget.classList[0])[0];
    let newFields = fields.cloneNode(true);

    const newId = `${Date.now()}`;
    const isLesson = this.fieldForValue === 'lessons';

    // When adding a section, keep only the first lesson-fields div
    if (!isLesson) {
      const lessonFields = newFields.querySelectorAll('div.lesson-fields');
      for (let i = 1; i < lessonFields.length; i++) {
        lessonFields[i].remove();
      }
    }

    // Patterns for sections
    const sectionIdPattern = new RegExp(`_course_sections_attributes_\\d+_`, "g");
    const sectionNamePattern = new RegExp(`\\[sections_attributes\\]\\[\\d+\\]`, "g");

    // Patterns for lessons
    const lessonIdPattern = new RegExp(`_lessons_attributes_\\d+_`, "g");
    const lessonNamePattern = new RegExp(`\\[lessons_attributes\\]\\[\\d+\\]`, "g");

    let sectionId = null;
    if (isLesson) {
      // Find the parent section ID from the closest section container
      const sectionContainer = this.wrapperTarget.closest('[data-section-container]') || this.wrapperTarget;
      console.log(sectionContainer)
      const sectionInput = sectionContainer.querySelector('input[name*="course[sections_attributes]"]');
      if (sectionInput) {
        const match = sectionInput.name.match(/course\[sections_attributes\]\[(\d+)\]/);
        sectionId = match ? match[1] : '0'; // Fallback to '0' if not found
      }
    }

    newFields.querySelectorAll("input, label, textarea, select").forEach(el => {
      const tag = el.tagName.toLowerCase();

      if (["input", "textarea", "select"].includes(tag)) {
        if (el.id) {
          if (isLesson) {
            // Replace lesson index
            el.id = el.id.replace(lessonIdPattern, `_lessons_attributes_${newId}_`);
            // Replace template section ID (0) with parent section ID
            if (sectionId) {
              el.id = el.id.replace(sectionIdPattern, `_course_sections_attributes_${sectionId}_`);
            }
          } else {
            // Replace section index (for adding sections)
            el.id = el.id.replace(sectionIdPattern, `_course_sections_attributes_${newId}_`);
            // Replace lesson index if present
            el.id = el.id.replace(lessonIdPattern, `_lessons_attributes_${newId}_`);
          }
        }
        if (el.name) {
          if (isLesson) {
            // Replace lesson index
            el.name = el.name.replace(lessonNamePattern, `[lessons_attributes][${newId}]`);
            // Replace template section ID (0) with parent section ID
            if (sectionId) {
              el.name = el.name.replace(sectionNamePattern, `[sections_attributes][${sectionId}]`);
            }
          } else {
            // Replace section index (for adding sections)
            el.name = el.name.replace(sectionNamePattern, `[sections_attributes][${newId}]`);
            // Replace lesson index if present
            el.name = el.name.replace(lessonNamePattern, `[lessons_attributes][${newId}]`);
          }
        }
      } else if (tag === "label") {
        if (el.htmlFor) {
          if (isLesson) {
            // Replace lesson index
            el.htmlFor = el.htmlFor.replace(lessonIdPattern, `_lessons_attributes_${newId}_`);
            // Replace template section ID (0) with parent section ID
            if (sectionId) {
              el.htmlFor = el.htmlFor.replace(sectionIdPattern, `_course_sections_attributes_${sectionId}_`);
            }
          } else {
            // Replace section index (for adding sections)
            el.htmlFor = el.htmlFor.replace(sectionIdPattern, `_course_sections_attributes_${newId}_`);
            // Replace lesson index if present
            el.htmlFor = el.htmlFor.replace(lessonIdPattern, `_lessons_attributes_${newId}_`);
          }
        }
      }
    });


    // Clear the input values in the cloned field
    newFields.querySelectorAll("input, textarea").forEach(el => {
      el.value = "";
      if (el.type === "checkbox") {
        el.checked = false;
      }
    });

    this.wrapperTarget.insertAdjacentElement("beforeend", newFields);
  }
}
