import ClipboardJS from "clipboard";
import "./copying-field.css";

document.addEventListener("DOMContentLoaded", () => {
  new ClipboardJS(".js-copy-link");
});
