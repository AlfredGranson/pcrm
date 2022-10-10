// We import the CSS which is extracted to its own file by esbuild.
import "../css/app.css"
import "../css/tachyons_v5_grid.css"; //This file is a placeholder for grid/tachyon support until v5 is available
import "tachyons";
import "@fortawesome/fontawesome-free/css/fontawesome.min.css";
import "@fortawesome/fontawesome-free/css/regular.min.css";

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// Show progress bar on live navigation and form submits
import topbar from "topbar"
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// Override the default notifications
import Swal from 'sweetalert2'
document.body.addEventListener('phoenix.link.click', function (e) {
  e.stopPropagation();

  var message = e.target.getAttribute("data-confirm");
  if(message){
    e.preventDefault();

    Swal.fire({
      html: message,
      showCancelButton: true,
      focusConfirm: false,
      confirmButtonText:'Ok',
      cancelButtonText: "cancel",
      buttonsStyling: false,
      reverseButtons: true,
      showClass: {
        popup: 'fade-in-scale'
      },
      customClass: {
        container: "cu-pointer",
        popup: "br2 cu-default",
        htmlContainer: "dark-gray",
        confirmButton: ["b--black-20","bn","bg-animate","bg-blue","br2","button-reset","dib","f6","fw6","hover-bg-dark-blue","mb3","no-underline",".outline-0", "ph3","ph4-l","pointer","pv2","pv3-l","white"],
        cancelButton: ["b--black-20","bn","bg-animate","bg-silver","br2","button-reset","dib","f6","fw6","hover-bg-gray","mb3","mr3","no-underline",".outline-0","ph3","ph4-l","pointer","pv2","pv3-l","white"]
      },
    }).then((result) => {
      if (result.isConfirmed) {
        e.target.removeAttribute("data-confirm");
        e.target.click();
        e.target.click();
      }
    });
  }

}, false);

