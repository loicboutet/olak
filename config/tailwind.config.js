const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        olak: {
          primary: '#9C8671',
          'primary-dark': '#7A6656',
          'primary-light': '#B89F8E',
          accent: '#D4A574',
          dark: '#2C2C2C',
          gray: '#F5F5F5',
          white: '#FFFFFF',
          success: '#4CAF50',
          warning: '#FF9800',
          error: '#F44336',
        }
      }
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
