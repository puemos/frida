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
    extend: {
      colors: {
        primary: {
          light: "#fdf3e2", // For lighter primary color
          default: "#9c27b0", // Normal primary color
          dark: "#673ab7", // Used for hover, active, etc.
        },
      },
    },
  },
};
