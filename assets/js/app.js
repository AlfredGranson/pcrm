/*
  This file compiles all the CSS and Javascript for the application. 
*/

/************* CSS *************/
// (css) styling for pcrm should be done via tachyons (https://tachyons.io) whenever possible.
// When not possible, supplementary css can be added to /assets/css/app.css

// pcrm-specific css
import "../css/app.css"

// tachyons grid support. This file is a placeholder for grid/tachyon support until v5 is available
import "../css/tachyons_v5_grid.css";

// tachyons css
import "tachyons";

// Font Awesome
import "@fortawesome/fontawesome-free/css/fontawesome.min.css";
import "@fortawesome/fontawesome-free/css/solid.min.css";

/************* JS *************/
// Javascript should be kept to a minimum except where necessary for the best user experience. 
// All pcrm javacript should be added/configured here.

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
      hideClass: {
        popup: 'fade-out-scale'
      },
      customClass: {
        container: "cu-pointer",
        popup: "br2 cu-default bn shadow-1",
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

