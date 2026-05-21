const plugin = require("tailwindcss/plugin");

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/pcrm_web.ex",
    "../lib/pcrm_web/**/*.*ex",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require("@tailwindcss/forms"),
    plugin(({ addVariant }) =>
      addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-click-loading", [
        ".phx-click-loading&",
        ".phx-click-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-submit-loading", [
        ".phx-submit-loading&",
        ".phx-submit-loading &",
      ])
    ),
  ],
};
