# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Development

No build step. Open any `.html` directly or serve with `npx serve .` / `python3 -m http.server 8080`. Tailwind CSS loads via CDN. Wotfard (brand font) is self-hosted in `assets/fonts/`.

## Architecture

Multi-page static site for **UrbanView** (urbanview.media), an ERP for outdoor media (OOH). Pages: `index`, `produto`, `mercado`, `sobre`, `faq`, `termos-de-uso`, `politica-de-privacidade`, `404`, plus the static blog in `blog/`. Feeds and crawler files: `sitemap.xml`, `feed.xml`, `robots.txt`. All assets self-contained in `assets/`. Shared tokens and components live in `assets/brand.css`. See `DESIGN.md` for component patterns.

Product content derives from the knowledge base in `../urbanview-app/docs`. When a claim about the market or the product changes there, update it here too.

## Nav

Logo: `assets/urbanview.png` (`h-6 w-auto`, width=1305 height=160), links to `index.html`.

Order: `[UrbanView]` | Produto | Mercado | Blog | Sobre | `[Solicitar demonstração]` (CTA).

Pages inside `blog/` prefix every asset and page link with `../`, except links between blog pages.

Active link: `text-sm font-medium style="color:#B35300;"` (see Acessibilidade). Inactive: `text-sm text-[#111111] hover:opacity-50 transition-opacity hidden md:block`.

CTA links to `mailto:contato@urbanview.media?subject=UrbanView - Solicitar demonstração`, `bg-[#FF7902] text-[#000000] hover:bg-[#D96500]`.

Standalone site. **UrbanView is presented as its own brand**, never as a Setbox division: no Setbox pitch, no "quem constrói" section, no link to setbox.com.br. The only Setbox mention is the copyright line in the footer, because Setbox Serviços Digitais is the legal entity.

## Footer

Four blocks: UrbanView logo + copyright + address + CNPJ; "UrbanView" column (Produto, Mercado, Blog, Sobre); "Contato" column (contato@urbanview.media, phone); "Institucional" column (FAQ, Termos, Privacidade). `404.html` carries the same four.

Address: `Av. Carneiro Leão, 563 - Zona 01<br>Maringá / PR - 87014-010`.

## Blog

`blog/index.html` lists posts with `.post-card`; each post is its own `blog/<slug>.html` using `.post` for the prose. No dates, no author byline, no tags: the source posts carry none. Post pages end with a "Continue lendo" block linking the other posts, then the shared CTA.

### Publishing a post: the full checklist

Nothing here is automated. Miss a step and the post ships broken in a way no page test catches.

1. Create `blog/<slug>.html` from an existing post
2. Add a `.post-card` to `blog/index.html`
3. Point **two** existing posts' "Continue lendo" at it, and pick two for its own. Each post links to exactly two related posts, never the whole catalogue
4. **Run `./scripts/og.sh`** to generate the social image, then point `og:image`, `twitter:image` and the JSON-LD `image` at `assets/og/<slug>.png`
5. Add the `<url>` to `sitemap.xml`, with `lastmod`
6. Add the `<item>` to `feed.xml`
7. Update the post count stated in this file

Step 4 is the one that fails silently: without it the post falls back to a broken image path, and nobody notices until someone shares the link.

15 posts, 400 to 600 words each. Every market figure carries its source in the body (CENP, Kantar Ibope, Nielsen, Central de Outdoor, ABA, IVC). Claims about mechanics come from `../urbanview-app/docs`: when a fact changes there, the post changes here.

Three posts carry slugs inherited from the previous OohMG blog, which was a test site: no redirect is owed to it. Their text was rewritten in the UrbanView voice. `anunciar-em-midia-ooh-de-asas-a-sua-marca` keeps its slug under the title "Como planejar uma campanha em mídia OOH", and renaming it costs nothing if you prefer.

## Institutional pages

`faq.html`, `termos-de-uso.html`, `politica-de-privacidade.html`, linked from the "Institucional" footer column on every page except `404.html`. They reuse the `.post` prose component.

The legal texts were adapted from the OohMG originals, which described accounting services ("assessoria administrativa e fiscal", IRPF, Conselho Federal de Contabilidade) and did not match what UrbanView does. The object of the contract is now the software licence. **They have not been reviewed by a lawyer.**

## Legal identity

UrbanView is a division of **SETBOX INFORMATICA LTDA** (nome fantasia Setbox Serviços Digitais), CNPJ 08.889.601/0001-09, Av. Carneiro Leão, 563 - Zona 01, Maringá/PR, 87014-010. Porte EPP.

Razão social and CNPJ appear only in `termos-de-uso.html` and `politica-de-privacidade.html` (opening paragraph and definitions). Every footer carries `© 2026 Setbox Serviços Digitais` plus the CNPJ line. Marketing pages stay UrbanView-only: the division is an internal fact, not a selling point.

## Brand

Official identity by DZ9 Design (2023). Source files: `~/setbox/divisoes/urbanview/biblioteca/branding-dz9/` (`cores.txt`, `Arquitetura_marca_Urban-View.pdf`, `PNG/`, `font-wotfard/`).

| Token | Valor | Pantone |
|---|---|---|
| Laranja | `#FF7902` | 164 C |
| Roxo | `#8248E4` | 2725 C |
| Preto | `#000000` | Black |

Laranja is the accent. Roxo is secondary: reserved for the "por que vertical", "fronteiras" and "estágio" sections, plus the "opção com prazo" state in the grid. Preto is a full-bleed section background, never body text on light backgrounds (body text is `#111111`).

Never recolor the logo. Use `assets/urbanview.png` on light backgrounds and `assets/urbanview-branco.png` on `#000000` or `#FF7902`.

## Typography

**Wotfard**, self-hosted WOFF, weights 400/500/600/700, declared in `assets/brand.css`. Only the `.woff` webfonts live in this public repo; the source `.otf` and `.ttf` stay in the branding folder. Fallback chain: `Inter, system-ui, -apple-system, sans-serif`. Headings use 700 (not 800, Wotfard has no heavier cut).

Preload `wotfard-regular.woff` and `wotfard-bold.woff` in every page head.

## Asset Paths

Root-relative: `assets/filename.ext`. No `../` prefixes, standalone repo.

| Arquivo | Caminho | Dimensões |
|---|---|---|
| Logo horizontal | `assets/urbanview.png` | 1305x160 |
| Logo horizontal branco | `assets/urbanview-branco.png` | 1305x160 |
| Ícone (escudo) | `assets/icone.png` | 200x200 |
| Logo horizontal preto | `assets/urbanview-preto.png` | 979x120 |
| OG padrão | `assets/og-image.png` | 1200x630 |
| OG por post | `assets/og/<slug>.png` | 1200x630 |
| Favicons | `assets/favicon.ico`, `favicon-32x32.png`, `favicon-16x16.png`, `apple-touch-icon.png` | |

Vertical logo and grafismo were dropped: nothing used them. Both are still in the branding folder if needed.

Regenerate derived assets from the branding folder with ImageMagick (`magick <origem> -trim +repage -resize x160 ...`), never by hand.

## Content Rules

- Language: Brazilian Portuguese
- No trailing period on any title or subtitle (h1-h6)
- Never use em dash anywhere, use hyphen, comma or colon
- Contact email: `contato@urbanview.media`. Domain: `urbanview.media`
- Domain vocabulary is fixed: **exibidora** is the customer, **face** is the sales unit, **bi-semana** is the time unit, **checking** is the delivery proof. Do not translate or soften these terms
- Market figures must keep their source visible (CENP, Kantar Ibope, Central de Outdoor, ABA, IVC)
- The product is under construction. Do not claim named customers, case studies or metrics the product has not produced

## Image Rules

- All `<img>` need `width`, `height` and `loading="lazy"`, except nav and footer logos (above the fold)

## Acessibilidade

Contraste mínimo 4,5:1 em todo texto. Consequências que já estão aplicadas e não devem ser revertidas:

- `--uv-laranja` (#FF7902) **nunca é cor de texto sobre fundo claro** (2,5:1). Texto laranja usa `--uv-laranja-texto` (#B35300, 4,8:1). O #FF7902 fica em preenchimento, borda, ícone e fundo.
- Sobre fundo laranja o texto é **preto**, não branco: branco sobre #FF7902 dá 2,6:1 e reprova até como texto grande.
- Cinzas de rodapé e legenda: #6E6E6E e #6B6B6B. Nunca #BBBBBB ou #888888.
- Toda página abre com `.skip-link` para `#conteudo`, que é o `<main tabindex="-1">`.
- O menu mobile devolve o foco ao botão ao fechar, fecha no Esc e fecha ao clicar fora. O script é idêntico em todas as páginas.
- `:focus-visible` tem contorno laranja de 3px, definido uma vez em `brand.css`.

## Dados estruturados

Toda página tem um bloco JSON-LD antes de `</head>`:

| Página | Tipo |
|---|---|
| `index.html` | `@graph` com Organization, WebSite e SoftwareApplication |
| `produto`, `mercado`, `sobre`, legais | WebPage |
| `faq.html` | FAQPage, gerado a partir dos `<h2>`/`<p>` da própria página |
| `blog/index.html` | Blog, com a lista de posts |
| posts | Article, sem data |

**Os posts não têm data.** O conteúdo é atemporal e por isso não há `datePublished`, `dateModified` nem data visível na página. Não adicione.

## Imagens sociais

Cada post do blog tem a sua, em `assets/og/<slug>.png`. As demais páginas usam a genérica `assets/og-image.png`, inclusive `blog/index.html`.

Geradas em lote por `scripts/og.sh`, que lê o `<h1>` de cada `blog/*.html` e compõe fundo laranja, logo preto e título em Wotfard Bold. O script é **idempotente**: sem argumento gera só o que falta, com `--force` regera tudo.

```bash
./scripts/og.sh            # OBRIGATÓRIO a cada post novo
./scripts/og.sh --force    # depois de mudar o layout da imagem
```

**Rodar o script é passo obrigatório de toda publicação**, não uma otimização opcional. O site é estático e não tem servidor: nada é gerado no deploy nem sob demanda. Post publicado sem rodar o script aponta para um arquivo que não existe, e a falha só aparece quando alguém compartilha o link.

Existe um hook de pre-commit que cobre isso, mas ele precisa ser instalado uma vez por máquina, porque o Git não distribui hooks pelo repositório:

```bash
./scripts/install-hooks.sh
```

O hook vive em `scripts/hooks/pre-commit`, versionado, e é ativado via `core.hooksPath`. Quando há post do blog no stage ele:

1. Roda `og.sh` e **acrescenta ao commit** a imagem que faltava
2. Avisa sobre o que não dá para automatizar: card ausente em `blog/index.html`, URL fora do `sitemap.xml`, item fora do `feed.xml`, post ainda apontando para a OG genérica, e "Continue lendo" com número de posts diferente de dois

Só a falha na geração da imagem bloqueia o commit. O resto é aviso, para não atrapalhar commit de rascunho. Para pular tudo: `git commit --no-verify`.

Depende do ImageMagick e da pasta de branding, localizada por `$UV_BRANDING` (padrão `~/setbox/divisoes/urbanview/biblioteca/branding-dz9`).

Ao criar um post, aponte `og:image`, `twitter:image` e o campo `image` do JSON-LD para a imagem dele.

## Feed

`feed.xml` na raiz, RSS 2.0, com os 15 posts. Toda página declara `<link rel="alternate" type="application/rss+xml">`. Ao publicar um post, acrescente o `<item>` no feed.

## SEO

Every page needs `meta[description]`, `link[canonical]`, Open Graph (`og:type/site_name/locale/url/title/description/image`) and Twitter card. `og:site_name` = "UrbanView". OG image `assets/og-image.png` (1200x630). Add `<link rel="preload" as="script">` before the Tailwind CDN tag. Keep `sitemap.xml` in sync when adding a page.
