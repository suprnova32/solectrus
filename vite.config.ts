import { defineConfig } from 'vite';
import { splitVendorChunkPlugin } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import FullReload from 'vite-plugin-full-reload';
import StimulusHMR from 'vite-plugin-stimulus-hmr';
import { brotliCompressSync } from 'zlib';
import gzipPlugin from 'rollup-plugin-gzip';
import { fileURLToPath, URL } from 'url';

export default defineConfig({
  plugins: [
    splitVendorChunkPlugin(),
    RubyPlugin(),
    StimulusHMR(),
    FullReload([
      'config/routes.rb',
      'app/views/**/*',
      'app/components/**/*',
      'config/locales/**/*.yml',
    ]),
    // Create gzip copies of relevant assets
    gzipPlugin(),
    // Create brotli copies of relevant assets
    gzipPlugin({
      customCompression: (content) => brotliCompressSync(Buffer.from(content)),
      fileName: '.br',
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./app/javascript/src', import.meta.url)),
    },
  },
  server: {
    hmr: {
      host: 'vite.solectrus.test',
      clientPort: 443,
    },
  },
});
