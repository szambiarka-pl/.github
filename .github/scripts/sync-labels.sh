#!/usr/bin/env bash
# Tworzy albo aktualizuje etykiety z .github/labels.json w jednym repozytorium
# tej samej organizacji. Nie usuwa etykiet, których nie ma w pliku.
# Token: zmienna GH_TOKEN, w workflow sekret LABELS_SYNC_TOKEN.
# GITHUB_TOKEN workflowu jest zdejmowany, żeby gh nie użył tokena tego repozytorium.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LABELS_FILE="${LABELS_FILE:-$ROOT/.github/labels.json}"

if [[ -z "${OWNER:-}" ]]; then
  echo "Brak OWNER. Workflow ustawia właściciela z github.repository_owner." >&2
  exit 1
fi

if [[ -z "${TARGET_NAME:-}" ]]; then
  echo "Podaj nazwę repozytorium w polu repository, bez właściciela (na przykład szambiarka)." >&2
  exit 1
fi

if [[ ! "$TARGET_NAME" =~ ^[A-Za-z0-9._-]+$ ]] || [[ "$TARGET_NAME" == *".."* ]]; then
  echo "Nazwa „${TARGET_NAME}” jest niedozwolona. Podaj samą nazwę repozytorium w tej organizacji, bez właściciela i bez ukośnika. Przykłady: szambiarka, .github." >&2
  exit 1
fi

if [[ ! -f "$LABELS_FILE" ]]; then
  echo "Brak pliku etykiet: $LABELS_FILE" >&2
  exit 1
fi

if ! jq -e '
  def bad_name:
    (.name | type) != "string"
    or (.name | length) < 1
    or (.name | length) > 50
    or (.name | test("^\\s|\\s$"));
  def bad_color:
    (.color | type) != "string"
    or (.color | test("^[0-9a-fA-F]{6}$") | not);
  def bad_description:
    (.description | type) != "string"
    or (.description | length) > 100;
  if type != "array" or length == 0 then
    error("labels.json musi być niepustą tablicą")
  elif (map(.name | ascii_downcase) | unique | length) != length then
    error("nazwy etykiet powtarzają się (GitHub porównuje je bez względu na wielkość liter)")
  else
    .[] | if bad_name then
      error("zła nazwa etykiety (1–50 znaków, bez spacji na brzegach): \(.name // "<brak>")")
    elif bad_color then
      error("kolor etykiety \(.name) musi mieć 6 znaków hex bez #: \(.color // "<brak>")")
    elif bad_description then
      error("opis etykiety \(.name) musi być tekstem do 100 znaków")
    else
      .
    end
  end
' "$LABELS_FILE" >/dev/null; then
  echo "Plik $LABELS_FILE nie przechodzi walidacji etykiet GitHuba." >&2
  exit 1
fi

if [[ -z "${GH_TOKEN:-}" ]]; then
  echo "Brak sekretu LABELS_SYNC_TOKEN. Dodaj go w Settings → Secrets and variables → Actions tego repozytorium (albo jako sekret organizacji udostępniony temu repozytorium). Opis tokena jest w README." >&2
  exit 1
fi

export GH_TOKEN
unset GITHUB_TOKEN

TARGET="${OWNER}/${TARGET_NAME}"
errfile="$(mktemp)"
trap 'rm -f "$errfile"' EXIT

if ! repo_json="$(gh api "/repos/${TARGET}" 2>"$errfile")"; then
  echo "Nie można odczytać ${TARGET}. Sprawdź nazwę oraz czy token ma dostęp do tego repozytorium." >&2
  cat "$errfile" >&2
  exit 1
fi

owner_login="$(jq -r '.owner.login // empty' <<<"$repo_json")"
if [[ "${owner_login,,}" != "${OWNER,,}" ]]; then
  echo "Repozytorium ${TARGET} należy do „${owner_login:-nieznany}”, a workflow działa tylko w obrębie ${OWNER}." >&2
  exit 1
fi

created=0
updated=0

while IFS= read -r row; do
  name="$(jq -r '.name' <<<"$row")"
  color="$(jq -r '.color' <<<"$row")"
  description="$(jq -r '.description' <<<"$row")"
  encoded="$(jq -rn --arg n "$name" '$n | @uri')"
  label_url="/repos/${TARGET}/labels/${encoded}"

  set +e
  raw="$(gh api --include "$label_url" 2>"$errfile")"
  set -e
  code="$(printf '%s\n' "$raw" | tr -d '\r' | awk 'tolower($1) ~ /^http\// { c=$2 } END { print c }')"

  if [[ "$code" == "200" ]]; then
    echo "aktualizuję: ${name}"
    jq -nc --arg color "$color" --arg description "$description" \
      '{color:$color, description:$description}' \
      | gh api --silent --method PATCH "$label_url" --input -
    updated=$((updated + 1))
  elif [[ "$code" == "404" ]]; then
    echo "tworzę: ${name}"
    jq -nc --arg name "$name" --arg color "$color" --arg description "$description" \
      '{name:$name, color:$color, description:$description}' \
      | gh api --silent --method POST "/repos/${TARGET}/labels" --input -
    created=$((created + 1))
  else
    echo "Odczyt etykiety „${name}” w ${TARGET} zwrócił status ${code:-brak}." >&2
    cat "$errfile" >&2
    exit 1
  fi
done < <(jq -c '.[]' "$LABELS_FILE")

echo "Gotowe: ${TARGET}. Utworzono ${created}, zaktualizowano ${updated}. Etykiet spoza pliku nie zmieniano."
