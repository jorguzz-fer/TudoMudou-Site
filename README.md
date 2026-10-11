# Tudo Mudou! — Site

Site institucional da Tudo Mudou Tech & Marketing. HTML, CSS e JS puros, sem build step, servidos por nginx.

## Estrutura

```
index.html      Home (hero, 7 frentes, cases, níveis, CTA, rodapé)
styles.css      Estilos (desktop, tablet e mobile)
main.js         Menu mobile
assets/         Logos
blog/           Listagem do blog (index.html) e modelo de artigo (_modelo-artigo.html)
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

## Conteúdo

A copy da home segue o documento "Tudo Mudou — Copy e diretrizes de implementação" (v1.0, 11/10/2026): hero, diferencial, soluções, projetos, como trabalho, parceria contínua, sobre e CTA final. Um único H1 na página; seções em H2; cartões em H3.

Todos os CTAs abrem o WhatsApp `+55 11 98994-0404` com mensagem pré-preenchida. A seção Parceria usa a mensagem específica de parceria recorrente; as demais usam a mensagem geral.

## Publicar um artigo no blog

1. Copie `blog/_modelo-artigo.html` para `blog/<slug>.html` e preencha os campos entre colchetes.
2. Em `blog/index.html`, adicione um cartão `.post-card` dentro de `.posts-grid` (o mais recente primeiro). O exemplo está comentado no próprio arquivo.
3. O bloco "Os primeiros artigos estão a caminho" some sozinho quando houver pelo menos um cartão.

## Ao alterar CSS ou JS

Atualize o parâmetro `?v=` nas tags `<link>` e `<script>` do `index.html`. Sem isso, navegadores e o Cloudflare continuam servindo a versão antiga.

## Pendências

- **Foto do Fernando**: a seção Sobre usa a assinatura "Uma decisão muda tudo" como imagem provisória. Salve a foto em `assets/fernando.jpg` e troque o `<img>` marcado com comentário em `index.html`.
- **Tudo Mudou Inside**: a oferta recorrente (seção 4 do documento de copy) ficou fora da home até escopo e preço serem validados.
- **Prova social**: confirmar "16 projetos entregues" e "6 setores atendidos" antes de divulgar.
