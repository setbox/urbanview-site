#!/usr/bin/env bash
#
# Gera uma imagem social (Open Graph) por post do blog.
#
#   ./scripts/og.sh            gera só o que falta
#   ./scripts/og.sh --force    regera tudo
#
# Cada imagem tem 1200x630, fundo laranja da marca, logo em preto e o título do
# post em Wotfard Bold. O título é lido do <h1> do próprio HTML, então basta
# rodar de novo depois de publicar um post.
#
# Requer ImageMagick (`brew install imagemagick`) e a pasta de branding.

set -euo pipefail

cd "$(dirname "$0")/.."

BRANDING="${UV_BRANDING:-$HOME/setbox/divisoes/urbanview/biblioteca/branding-dz9}"
FONT="$BRANDING/font-wotfard/Wotfard-Bold.otf"
LOGO="assets/urbanview-preto.png"
OUT="assets/og"

LARANJA="#FF7902"
TINTA="#000000"

W=1200
H=630
MARGEM=80

FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

for dep in magick python3; do
  command -v "$dep" >/dev/null || { echo "erro: $dep não encontrado"; exit 1; }
done
[ -f "$FONT" ] || { echo "erro: fonte não encontrada em $FONT"; echo "defina UV_BRANDING apontando para a pasta de branding"; exit 1; }
[ -f "$LOGO" ] || { echo "erro: $LOGO não encontrado"; exit 1; }

mkdir -p "$OUT"

gerados=0
pulados=0

for arquivo in blog/*.html; do
  slug="$(basename "$arquivo" .html)"
  [ "$slug" = "index" ] && continue

  destino="$OUT/$slug.png"
  if [ -f "$destino" ] && [ "$FORCE" -eq 0 ]; then
    pulados=$((pulados + 1))
    continue
  fi

  titulo="$(python3 - "$arquivo" <<'PY'
import html, re, sys
s = open(sys.argv[1], encoding='utf-8').read()
m = re.search(r'(?s)<h1[^>]*>(.*?)</h1>', s)
print(html.unescape(re.sub(r'<[^>]+>', '', m.group(1))).strip())
PY
)"

  # título: caixa de largura fixa, corpo ajustado automaticamente pelo caption
  magick -background none -fill "$TINTA" -font "$FONT" \
    -size $((W - MARGEM * 2))x300 -gravity northwest \
    caption:"$titulo" /tmp/uv-og-titulo.png

  magick -size ${W}x${H} "xc:$LARANJA" \
    \( "$LOGO" -resize x40 \) -geometry +${MARGEM}+${MARGEM} -compose over -composite \
    /tmp/uv-og-titulo.png -geometry +${MARGEM}+200 -compose over -composite \
    \( -background none -fill "$TINTA" -font "$FONT" -pointsize 24 label:"urbanview.media" \) \
    -geometry +${MARGEM}+$((H - MARGEM - 24)) -compose over -composite \
    "$destino"

  echo "gerado $destino"
  gerados=$((gerados + 1))
done

rm -f /tmp/uv-og-titulo.png

echo "---"
echo "$gerados gerado(s), $pulados já existia(m)"
[ "$FORCE" -eq 0 ] && [ "$pulados" -gt 0 ] && echo "use --force para regerar tudo"
exit 0
