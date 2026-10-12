# Tudo Mudou! — Site

Site institucional da Tudo Mudou Tech & Marketing. HTML, CSS e JS puros, sem build step, servidos por nginx.

## Estrutura

```
index.html      Home (hero, 7 frentes, cases, níveis, CTA, rodapé)
styles.css      Estilos (desktop, tablet e mobile)
main.js         Menu mobile
assets/         Logos
blog/           Listagem (index.html), índice dos artigos (posts.json) e modelo de artigo (_modelo-artigo.html)
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

## Blog: publicação automática pelo Content Machine

Os artigos do blog são escritos e aprovados no [Content Machine](https://github.com/jorguzz-fer/content)
(plataforma **Blog** no editor de posts). Ao clicar em **Publicar no blog**, o Content Machine faz **um commit**
neste repositório, na branch `main`, com três arquivos:

| Arquivo | O que acontece |
| --- | --- |
| `blog/<slug>.html` | Artigo gerado a partir de `blog/_modelo-artigo.html` (campos `{{title}}`, `{{body_html}}` etc.). |
| `blog/posts.json` | Índice de todos os artigos publicados (slug, título, resumo, categoria, data, tempo de leitura). Fonte da verdade da listagem. |
| `blog/index.html` | Os cartões entre `<!-- POSTS:START -->` e `<!-- POSTS:END -->` são regerados a partir do `posts.json`, mais recente primeiro. |

O Coolify faz o deploy automático a cada push na `main` (item 7 de "Deploy no Coolify"), então o artigo
aparece no site poucos minutos depois do clique. Republicar o mesmo post reescreve o artigo e o cartão
no mesmo slug.

Regras que o Content Machine espera deste repositório:

- `blog/_modelo-artigo.html` é buscado no momento da publicação; mudanças de layout aqui valem para os
  próximos artigos sem mexer no Content Machine. Mantenha os campos `{{...}}` listados no comentário do arquivo.
- Os marcadores `POSTS:START`/`POSTS:END` precisam continuar dentro de `.posts-grid`. Tudo entre eles é
  reescrito; o restante do `index.html` não é tocado.
- O token usado pelo Content Machine (`BLOG_GITHUB_TOKEN`) precisa de permissão de leitura e escrita em
  **Contents** só deste repositório (fine-grained personal access token).

Para publicar à mão, siga o mesmo contrato: copie o modelo para `blog/<slug>.html` trocando os campos
`{{...}}`, acrescente a entrada em `blog/posts.json` e insira o cartão entre os marcadores (exemplo no
comentário de `blog/index.html`). O bloco "Os primeiros artigos estão a caminho" some sozinho quando
houver pelo menos um cartão.

## Ao alterar CSS ou JS

Atualize o parâmetro `?v=` nas tags `<link>` e `<script>` do `index.html`, de `blog/index.html` e de `blog/_modelo-artigo.html` (os artigos já publicados em `blog/*.html` também). Sem isso, navegadores e o Cloudflare continuam servindo a versão antiga.

## Pendências

- **Foto do Fernando**: a seção Sobre usa a assinatura "Uma decisão muda tudo" como imagem provisória. Salve a foto em `assets/fernando.jpg` e troque o `<img>` marcado com comentário em `index.html`.
- **Tudo Mudou Inside**: a oferta recorrente (seção 4 do documento de copy) ficou fora da home até escopo e preço serem validados.
- **Prova social**: confirmar "16 projetos entregues" e "6 setores atendidos" antes de divulgar.
