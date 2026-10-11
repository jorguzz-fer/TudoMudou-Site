# Tudo Mudou! — Site

Site institucional da Tudo Mudou Tech & Marketing. HTML, CSS e JS puros, sem build step, servidos por nginx.

## Estrutura

```
index.html      Home (hero, 7 frentes, cases, níveis, CTA, rodapé)
styles.css      Estilos (desktop, tablet e mobile)
main.js         Menu mobile
assets/         Logos
Dockerfile      Imagem nginx para produção
nginx.conf      Config do nginx (gzip, cache, /healthz)
```

## Rodar localmente

Com Docker:

```bash
docker build -t tudomudou-site .
docker run --rm -p 8080:80 tudomudou-site
# abra http://localhost:8080
```

Sem Docker, qualquer servidor estático serve:

```bash
python3 -m http.server 8080
```

## Deploy no Coolify

1. No Coolify, crie um **Project** e dentro dele um **Resource → Application → Public Repository** (ou Private via GitHub App).
2. Repositório: `https://github.com/jorguzz-fer/TudoMudou-Site`, branch `main`.
3. **Build Pack**: `Dockerfile` (o Coolify detecta o `Dockerfile` na raiz automaticamente).
4. **Ports Exposes**: `80`.
5. Em **Domains**, informe o domínio final (ex.: `https://tudomudou.com.br`). O Coolify emite o certificado via Let's Encrypt.
6. Clique em **Deploy**.
7. Opcional: em **Webhooks / Auto Deploy**, ative o deploy automático a cada push na branch `main`.

Health check: `GET /healthz` responde `200 ok`. O `Dockerfile` já declara um `HEALTHCHECK`, e o Coolify o utiliza para marcar o container como saudável.

## Antes de ir ao ar

- **WhatsApp**: troque o número placeholder em `index.html` (link `https://wa.me/5511999999999...`, marcado com `data-whatsapp`) pelo número real.
- **Links do rodapé**: Política de privacidade, Termos e Área do cliente apontam para `#` até as páginas existirem.
- **Produtos / Sobre / Blog**: o menu aponta para âncoras da home até as páginas serem criadas.
