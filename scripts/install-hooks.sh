#!/usr/bin/env bash
#
# Aponta o Git deste clone para os hooks versionados em scripts/hooks.
# Rode uma vez por máquina. O Git não distribui hooks pelo repositório.
#
#   ./scripts/install-hooks.sh
#
# Para desfazer:
#
#   git config --unset core.hooksPath

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

chmod +x scripts/hooks/*
git config core.hooksPath scripts/hooks

echo "hooks instalados: $(git config core.hooksPath)"
ls -1 scripts/hooks | sed 's/^/  /'
echo
echo "Para pular em um commit específico: git commit --no-verify"
