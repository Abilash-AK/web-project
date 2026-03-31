export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          dark: '#14181c',
          darker: '#1c2026',
          light: '#2c3440',
        },
        accent: {
          green: '#00c030',
          orange: '#ff8000',
          blue: '#40bcf4',
        },
        text: {
          primary: '#ffffff',
          secondary: '#9ab',
          muted: '#678',
        }
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
