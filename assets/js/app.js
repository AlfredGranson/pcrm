// Phoenix
import "phoenix_html";
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import Swal from "sweetalert2";

// Confirmation dialog via SweetAlert2
function swalConfirm(message, callback) {
  Swal.fire({
    html: message,
    showCancelButton: true,
    focusConfirm: false,
    confirmButtonText: "Ok",
    cancelButtonText: "Cancel",
    buttonsStyling: false,
    reverseButtons: true,
    showClass: { popup: "fade-in-scale" },
    hideClass: { popup: "fade-out-scale" },
    customClass: {
      container: "cursor-pointer",
      popup: "rounded-xl shadow-lg border-0 w-auto p-6",
      htmlContainer: "text-gray-800",
      confirmButton:
        "rounded-lg bg-blue-600 hover:bg-blue-700 py-2 px-4 text-sm font-semibold text-white cursor-pointer border-0",
      cancelButton:
        "rounded-lg bg-gray-400 hover:bg-gray-500 py-2 px-4 text-sm font-semibold text-white cursor-pointer border-0 mr-2",
    },
  }).then((result) => {
    if (result.isConfirmed) callback();
  });
}

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  confirm: swalConfirm,
});

liveSocket.connect();
window.liveSocket = liveSocket;

// Progress bar
import topbar from "topbar";
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());
