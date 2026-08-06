# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Development

No build step. Open any `.html` directly or serve with `npx serve .` / `python3 -m http.server 8080`. Tailwind CSS loads via CDN. Wotfard (brand font) is self-hosted in `assets/fonts/`.

## Architecture

Multi-page static site for **UrbanView** (urbanview.media), an ERP for outdoor media (OOH). Pages: `index`, `produto`, `mercado`, `sobre`, `404`, plus the static blog in `blog/`. All assets self-contained in `assets/`. Shared tokens and components live in `assets/brand.css`. See `DESIGN.md` for component patterns.

Product content derives from the knowledge base in `../urbanview-app/docs`. When a claim about the market or the product changes there, update it here too.

## Nav

Logo: `assets/urbanview.png` (`h-6 w-auto`, width=1305 height=160), links to `index.html`.

Order: `[UrbanView]` | Produto | Mercado | Blog | Sobre | `[Solicitar demonstração]` (CTA).

Pages inside `blog/` prefix every asset and page link with `../`, except links between blog pages.

Active link: `text-sm font-medium style="color:#FF7902;"`. Inactive: `text-sm text-[#111111] hover:opacity-50 transition-opacity hidden md:block`.

CTA links to `mailto:contato@urbanview.media?subject=UrbanView - Solicitar demonstração`, `bg-[#FF7902] hover:bg-[#D96500]`.

Standalone site. **UrbanView is presented as its own brand**, never as a Setbox division: no Setbox pitch, no "quem constrói" section, no link to setbox.com.br. The only Setbox mention is the copyright line in the footer, because Setbox Serviços Digitais is the legal entity.

## Footer

Three blocks: UrbanView logo + copyright + address; "UrbanView" column (Produto, Mercado, Blog, Sobre); "Contato" column (contato@urbanview.media, phone). `404.html` carries the logo block only.

Address: `Av. Carneiro Leão, 563 - Zona 01<br>Maringá / PR - 87014-010`.

## Blog

`blog/index.html` lists posts with `.post-card`; each post is its own `blog/<slug>.html` using `.post` for the prose. No dates, no author byline, no tags: the source posts carry none. Post pages end with a "Continue lendo" block linking the other posts, then the shared CTA.

To add a post: create `blog/<slug>.html` from an existing one, add a `.post-card` to `blog/index.html`, add the cross-links in the other posts' "Continue lendo", and add the URL to `sitemap.xml`.

The three current posts kept the slugs of the previous OohMG blog so the old URLs stay redirectable, but the text was rewritten in the UrbanView voice: editorial, sourced, no hype. `anunciar-em-midia-ooh-de-asas-a-sua-marca` keeps its slug under the new title "Como planejar uma campanha em mídia OOH".

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

**Wotfard**, self-hosted WOFF, weights 400/500/600/700, declared in `assets/brand.css`. Fallback chain: `Inter, system-ui, -apple-system, sans-serif`. Headings use 700 (not 800, Wotfard has no heavier cut).

Preload `wotfard-regular.woff` and `wotfard-bold.woff` in every page head.

## Asset Paths

Root-relative: `assets/filename.ext`. No `../` prefixes, standalone repo.

| Arquivo | Caminho | Dimensões |
|---|---|---|
| Logo horizontal | `assets/urbanview.png` | 1305x160 |
| Logo horizontal branco | `assets/urbanview-branco.png` | 1305x160 |
| Logo vertical | `assets/urbanview-vertical.png` | 1309x400 |
| Ícone (escudo) | `assets/icone.png` | 200x200 |
| Grafismo | `assets/grafismo.png` | 600x451 |
| OG image | `assets/og-image.png` | 1200x630 |
| Favicons | `assets/favicon.ico`, `favicon-32x32.png`, `favicon-16x16.png`, `apple-touch-icon.png` | |

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

## SEO

Every page needs `meta[description]`, `link[canonical]`, Open Graph (`og:type/site_name/locale/url/title/description/image`) and Twitter card. `og:site_name` = "UrbanView". OG image `assets/og-image.png` (1200x630). Add `<link rel="preload" as="script">` before the Tailwind CDN tag. Keep `sitemap.xml` in sync when adding a page.
