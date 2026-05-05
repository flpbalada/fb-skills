import { defineConfig } from 'astro/config';

export default defineConfig({
  output: 'static',
  vite: {
    plugins: [renderSkillMarkdownRequests()],
    server: {
      fs: {
        deny: ['skills/**']
      }
    }
  }
});

function renderSkillMarkdownRequests() {
  return {
    name: 'render-skill-markdown-requests',
    configureServer(server) {
      server.middlewares.use((request, _response, next) => {
        const url = request.url || '';
        const [pathname, search = ''] = url.split('?');

        if (!pathname.startsWith('/skills/')) return next();
        if (!pathname.endsWith('.md')) return next();

        request.url = `${pathname}/${search ? `?${search}` : ''}`;
        next();
      });
    }
  };
}
