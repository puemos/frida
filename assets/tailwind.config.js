const { colors } = require("tailwindcss/defaultTheme");

module.exports = {
  purge: {
    enabled: process.env.MIX_ENV === "prod",
    content: ["../lib/**/*.eex", "../lib/**/*.leex"],
    options: {
      whitelist: [],
    },
  },
  plugins: [],
  theme: {
    fontFamily: {
      display: ["Inter", "system-ui", "sans-serif"],
      body: ["Inter", "system-ui", "sans-serif"],
    },
  },
};
