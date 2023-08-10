import djangoVitePlugin from 'django-vite-plugin';
import path from 'path';
import { defineConfig } from 'vite';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    djangoVitePlugin({
      input: [
        'js/main.js',
        'css/style.css',

      ],
      pyPath: path.join(process.env.VIRTUAL_ENV, 'bin', 'python3'),
    })
  ],
});
