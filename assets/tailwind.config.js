const { colors } = require("tailwindcss/defaultTheme");

module.exports = {
  purge: {
    enabled: process.env.MIX_ENV === "prod",
    content: ["../lib/**/*.eex", "../lib/**/*.leex"],
    options: {
      whitelist: [],
    },
  },
  plugins: [require("kutty")],
  theme: {
    fontFamily: {
      body: ["Inter", "sans-serif"],
    },
    extend: {
      colors: {
        primary: {
          light: colors.white, // For lighter primary color
          default: colors.red[500], // Normal primary color
          dark: colors.red[700], // Used for hover, active, etc.
        },
        secondary: {
          light: colors.blue[200], // For lighter primary color
          default: colors.blue[500], // Normal primary color
          dark: colors.blue[700], // Used for hover, active, etc.
        },
      },
    },
  },
};
