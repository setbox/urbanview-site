# Design Reference - UrbanView

Identidade oficial da marca UrbanView, criada pela DZ9 Design em 2023, aplicada ao site
urbanview.media. Arquivos-fonte em `~/setbox/divisoes/urbanview/biblioteca/branding-dz9/`.

---

## Identidade Visual

**Filosofia:** editorial minimalista, mesma linha dos demais sites do grupo (Setbox, Agroprocess,
Integra Moda). Quase zero ornamento: tipografia, espaçamento e uso cirúrgico do laranja. A marca é
técnica e angular, e o layout não compete com ela.

**Paleta da marca**

| Token | Valor | Pantone | Uso |
|---|---|---|---|
| `laranja` | `#FF7902` | 164 C | Accent: CTAs, labels de seção, ícones, números, seção CTA final |
| `laranja-hover` | `#D96500` | n/a | Hover de botão primário |
| `laranja-lt` | `#FFF3E8` | n/a | Fundo de seção suave, fundo de ícone em card |
| `laranja-soft` | `#FFE6CE` | n/a | Texto de apoio sobre fundo laranja |
| `roxo` | `#8248E4` | 2725 C | Secundário: estado de opção na grade, rótulos de nível |
| `roxo-dark` | `#5C2FB0` | n/a | Label de seção sobre fundo roxo claro |
| `roxo-lt` | `#F3EDFD` | n/a | Fundo da seção "por que vertical" |
| `preto` | `#000000` | Black | Fundo de seção full-bleed |

**Paleta base do sistema**

| Token | Valor | Uso |
|---|---|---|
| `bg` | `#FAFAFA` | Fundo padrão |
| `text` | `#111111` | Texto primário |
| `text-muted` | `#555555` a `#888888` | Texto secundário |
| `border` | `#E5E5E5` | Divisores e bordas de card |

Regra de proporção: o laranja aparece em rótulo, ícone, número e botão. Não vira fundo de card nem
área grande, exceto na seção de CTA final e no OG image.

---

## Tipografia

**Wotfard**, a fonte da marca, auto-hospedada em `assets/fonts/` no formato WOFF (pesos 400, 500,
600, 700). Declarada em `assets/brand.css`. Fallback: Inter, system-ui.

| Nível | Tamanho | Peso | Uso |
|---|---|---|---|
| Display | 38-52px | 700 | H1 do hero |
| H1 interno | 34-46px | 700 | H1 de página interna |
| H2 | 26-38px | 700 | Títulos de seção |
| H3 | 15-17px | 600 | Cabeçalho de card |
| Body | 15-17px | 400 | Parágrafos |
| Small | 13-14px | 400-500 | Texto de card, bullets |
| Caption | 11-12px | 400-600 | Labels, rodapé, legendas |

Wotfard não tem peso 800: onde os outros sites usam `font-extrabold`, aqui é `font-bold` com
`tracking-[-0.03em]` nos títulos grandes.

**Label de seção**

```html
<p class="label-accent mb-3">Produto</p>   <!-- laranja -->
<p class="label-roxo mb-3">Fronteiras</p>  <!-- roxo -->
```

---

## Layout e Grid

**Max width:** `max-w-5xl` (1024px) na nav e no rodapé, `.container-inner` (1024px, padding 32px)
no conteúdo. **Padding mobile:** 16px.

Two-col: `display:grid;grid-template-columns:1fr 1fr;gap:64px` com a classe `two-col`.
Three-col: `repeat(3,1fr);gap:16px` com a classe `three-col`.
Stats: `repeat(4,1fr);gap:32px` com a classe `stats-grid`.

As classes `two-col`, `three-col` e `stats-grid` existem só para o breakpoint: em até 768px viram
uma coluna (duas, no caso de stats) via `assets/brand.css`.

**Ritmo vertical:** seção padrão 80px, hero e CTA 96px, faixa de números 56px. Em mobile todas caem
para 56px.

---

## Componentes

Todos definidos em `assets/brand.css`.

### Botões

```html
<a class="btn-primary">Solicitar demonstração</a>   <!-- laranja sobre fundo claro -->
<a class="btn-ghost">Ver o produto →</a>            <!-- outline sobre fundo claro -->
<a class="btn-on-orange">Solicitar demonstração</a> <!-- preto sobre fundo laranja -->
<a class="btn-on-dark">Ver o produto →</a>          <!-- laranja sobre fundo preto -->
```

### Card

```html
<div class="border border-[#E5E5E5] rounded-xl bg-white p-6">...</div>
```

Em seção laranja clara: `border-[#F0DCC6]`. Em seção roxa clara: `border-[#E3D8F7]`. Em seção preta:
`style="border:1px solid #2A2A2A;background:#0B0B0B;"`.

### Ícone de card

```html
<div class="icon-box">
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#FF7902" stroke-width="2" ...></svg>
</div>
```

`.icon-box-lg` (40px) para emoji em card de persona.

### Grade bi-semanal

Componente-assinatura do produto, usado no hero. `.cell` com três estados:

| Classe | Estado | Cor |
|---|---|---|
| `.cell-firme` | Vendido | `#FF7902` |
| `.cell-opcao` | Opção com prazo | `#8248E4` a 55% |
| `.cell-livre` | Livre | `#F0F0F0` com borda `#E5E5E5` |

Cabeçalho de coluna é o número par da bi-semana, linha é o código da face (`A-101/1`).

### Fluxo do ciclo comercial

`.flow` com `.flow-step` e `.flow-arrow`, sobre fundo preto. Oito passos: disponibilidade, proposta,
PI, produção, veiculação, checking, faturamento, comissão. Em mobile as setas somem e os passos
empilham.

### Badges de estado

```html
<span class="badge badge-red">CONFLITO</span>
<span class="badge badge-yellow">LENTO</span>
<span class="badge badge-gray">SEM PROVA</span>
<span class="badge badge-orange">FIRME</span>
<span class="badge badge-roxo">OPÇÃO</span>
```

### Passos numerados

`.step` com `.step-n` (círculo laranja). Usado na implantação (`produto.html`) e na parceria
(`sobre.html`).

### Tabela

`.table-wrap` (borda, raio e `overflow-x:auto`) envolvendo `.uv-table`. Cabeçalho em caixa alta 11px
cinza, células 13px.

### Bullets

```html
<li class="bullet"><span class="bullet-mark">→</span>Texto do item</li>
```

### Blog

Listagem: `.post-card`, um link de bloco com título 22px/600, resumo 14px cinza e "Leia mais →" em
laranja, separados por linha de 1px. Sem thumbnail, sem card com sombra, sem tag colorida.

Post: `.post`, coluna de 680px. Primeiro parágrafo em `.lead` (18px, peso 500, preto), corpo em 16px
com `line-height: 1.8`. Lista com marcador `→` laranja via `::before`. Cabeçalho do post é só o
título, precedido do link `← Blog`.

### Números

`.stat-num` (40px, 700, laranja) sobre `.stat-cap` (12px, caixa alta). Sempre com a fonte do dado
declarada abaixo da faixa.

---

## Ativos da marca

Versão principal é a **vertical**; no site usamos a **horizontal**, por causa da altura da nav.

| Contexto | Arquivo |
|---|---|
| Fundo claro | `assets/urbanview.png` (policromia: escudo laranja, texto preto) |
| Fundo preto ou laranja | `assets/urbanview-branco.png` |
| Empilhado | `assets/urbanview-vertical.png` |
| Ícone isolado | `assets/icone.png` (escudo) |
| Grafismo | `assets/grafismo.png` (recorte do escudo, para faixas) |

Proibido: recolorir, aplicar sombra ou gradiente, distorcer, girar, ou usar a policromia sobre fundo
escuro.

---

## Tom Visual Geral

- **Zero decoração:** sem gradiente, sem sombra, sem ilustração, sem foto de banco de imagem
- **A prova é o produto:** a grade bi-semanal e o fluxo do ciclo substituem screenshot genérico
- **Números com fonte:** todo dado de mercado carrega a origem por escrito
- **Densidade baixa:** uma ideia por bloco, muito espaço entre seções
- **Vocabulário do mercado:** face, bi-semana, PI, checking e calhau aparecem sem tradução, porque é
  assim que o cliente fala
