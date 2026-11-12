# Szablony organizacji Szambiarka.pl

Prywatne repozytorium `szambiarka-pl/.github` trzyma wspólne formularze issues i zestaw etykiet workstreamu treści SEO. Samo istnienie tych plików niczego nie zakłada: issues powstają dopiero, gdy ktoś je otworzy, a etykiety dopiero po ręcznym uruchomieniu workflow opisanego niżej.

## Co jest w repozytorium

| Ścieżka | Rola |
| --- | --- |
| `.github/ISSUE_TEMPLATE/config.yml` | Konfiguracja wyboru szablonu. Puste issue zostaje włączone. Obok są linki do mapy fraz, planu poradnika, briefu stron lokalnych i rejestru decyzji. |
| `.github/ISSUE_TEMPLATE/epic-tresci.yml` | Formularz epika treści. |
| `.github/ISSUE_TEMPLATE/strona-artykul.yml` | Formularz jednej strony, artykułu, szablonu sekcji albo decyzji o URL. |
| `.github/labels.json` | Definicje etykiet priorytetu, typu, obszaru i flag. To źródło synchronizacji, nie lista już istniejących etykiet. |
| `.github/workflows/sync-labels.yml` | Ręczne przeniesienie etykiet z pliku do jednego repozytorium organizacji. Skrypt wołany przez workflow to `.github/scripts/sync-labels.sh`. |
| `docs/ISSUES_STRUCTURE.md` | Projekt kolejki epików, workstreamu i pól projektu GitHub. Zdanie, że repozytorium `.github` „dziś nie ma”, opisuje moment pisania tego projektu. |

Na liście wyboru GitHub układa szablony alfabetycznie według nazwy pliku, więc „Epik treści” jest przed „Strona lub artykuł”. `config.yml` nie jest szablonem, tylko ustawieniem tego wyboru.

## Jak działają domyślne szablony organizacji

GitHub bierze domyślne pliki community health z repozytorium o nazwie `.github` należącego do organizacji albo do konta osobistego. Formularze issues i `config.yml` są takim plikiem. Leżą w `.github/ISSUE_TEMPLATE`, i tylko z tego katalogu GitHub je czyta. W tym repozytorium ścieżka jest właśnie taka.

Gdy domyślne pliki obowiązują, GitHub podkłada je w każdym repozytorium tego samego właściciela, które nie ma własnego pliku danego rodzaju. Widoczność repozytorium docelowego nie ma tu znaczenia: ten sam zestaw dotyczy repozytoriów publicznych i prywatnych. Plików domyślnych nie widać w drzewie, historii gita, klonie, paczce ani archiwum takiego repozytorium. Zmiana w tym jednym miejscu zmienia zachowanie wszędzie tam, gdzie lokalny plik nie wchodzi na miejsce domyślnego.

Dla plików, które mogą leżeć w kilku miejscach, GitHub szuka najpierw w katalogu `.github`, potem w korzeniu, potem w `docs`. Szablony issues mają jedną dopuszczalną lokalizację: `.github/ISSUE_TEMPLATE`.

Nadpisanie jest całościowe. Własny, poprawny katalog `.github/ISSUE_TEMPLATE` w repozytorium (szablony albo własny `config.yml`) zastępuje cały domyślny katalog. GitHub nie dokłada wtedy pojedynczych plików z repozytorium organizacji.

`blank_issues_enabled: true` zostawia na liście zwykłe, puste issue. Dzięki temu repozytorium kodu, które własnych szablonów nie ma, nadal przyjmuje zgłoszenia inne niż treść SEO. Przy wartości `false` puste issue zostaje tylko dla osób z prawem zapisu i wyższym, z podpisem „Maintainers only”.

Etykieta wpisana w polu `labels` szablonu trafia na nowe issue tylko wtedy, gdy już istnieje. Dokumentacja mówi, że etykieta ustawiana przez szablon ma być utworzona w repozytorium `.github` oraz w każdym repozytorium, w którym szablon będzie użyty. Brak etykiety nie psuje formularza: GitHub po prostu jej nie dopisuje.

Walidacja `required` blokuje wysłanie formularza tylko w repozytorium publicznym. W repozytorium prywatnym GitHub przyjmie formularz także z pustym polem oznaczonym jako wymagane. Checklista akceptacji w formularzu strony i tak jest obowiązkowa operacyjnie dopiero na etapie „Zaakceptowane”, nie przy otwarciu issue na etapie Brief.

Źródła, stan na 12 listopada 2026:

- [Creating a default community health file](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file)
- [Configuring issue templates for your repository](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository)
- [Syntax for issue forms](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms)
- [Syntax for GitHub's form schema](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-githubs-form-schema)

## Prywatne `.github` a dziedziczenie

Dokumentacja stawia warunek wprost: repozytorium z domyślnymi plikami community health ma być publiczne. W kroku tworzenia GitHub każe ustawić widoczność Public i dopowiada, że repozytorium na pliki domyślne nie może być prywatne.

`szambiarka-pl/.github` jest prywatne, więc inne repozytoria organizacji nie dostają z niego szablonów issues, `config.yml` ani pozostałych plików community health. Formularze są tu zapisane i gotowe do przejrzenia, a lista „New issue” w pozostałych repozytoriach ich nie pokazuje.

Zmiana widoczności tego repozytorium na publiczną włącza dziedziczenie. GitHub zaczyna wtedy używać tych plików w każdym repozytorium organizacji, publicznym i prywatnym, które nie ma własnego `.github/ISSUE_TEMPLATE`. Upublicznienie odsłania całą zawartość, także `docs/ISSUES_STRUCTURE.md`, opisy etykiet i ten README. Osobnego mechanizmu „prywatne `.github` tylko dla prywatnych repozytoriów” dokumentacja nie opisuje.

## Synchronizacja etykiet

Workflow **Synchronizacja etykiet** startuje wyłącznie przez **Run workflow** (`workflow_dispatch`). Nie ma wyzwalacza `push`, `pull_request` ani `schedule`. Zmergowanie pliku workflow niczego nie uruchamia i żadnej etykiety nie zakłada. Workflow pojawia się w zakładce Actions po wejściu na gałąź domyślną `main`. Jeśli Actions w tym repozytorium są wyłączone, trzeba je włączyć raz, zanim przycisk uruchomienia będzie dostępny.

Jedno uruchomienie dotyczy jednego repozytorium. W polu `repository` podaje się samą nazwę, bez właściciela: `szambiarka` albo `.github`. Workflow składa adres jako `<właściciel tego repozytorium>/<podana nazwa>`, więc nazwa z ukośnikiem albo wskazująca inne konto jest odrzucana, zanim padnie jakikolwiek zapis.

Dla każdej pozycji z `.github/labels.json` przebieg:

- tworzy etykietę, gdy w docelowym repozytorium jej nie ma;
- ustawia kolor i opis z pliku, gdy etykieta o tej nazwie już jest.

Etykiet spoza pliku workflow nie usuwa i nie zmienia. Istniejące etykiety kodu zostają. Przerwany przebieg można uruchomić ponownie: utworzone etykiety zostaną tylko dopasowane kolorem i opisem.

Żeby szablony mogły dopisywać `typ: epic` i `flaga: soft-open`, te etykiety muszą istnieć i w `.github`, i w repozytorium, w którym ktoś otwiera issue. Służy do tego to samo uruchomienie, raz z nazwą `.github`, raz z nazwą docelowego repozytorium (na przykład `szambiarka`).

### Sekret `LABELS_SYNC_TOKEN`

`GITHUB_TOKEN` workflowu ma dostęp tylko do tego repozytorium i etykiet w innym repozytorium nie założy. Krok synchronizacji czyta sekret o nazwie **`LABELS_SYNC_TOKEN`**.

Trzeba go dodać ręcznie, zanim pierwsze uruchomienie się uda:

1. Otwórz `szambiarka-pl/.github` → **Settings** → **Secrets and variables** → **Actions**.
2. **New repository secret**. Nazwa dokładnie: `LABELS_SYNC_TOKEN`.
3. W wartości wklej token konta, które może zmieniać issues w docelowych repozytoriach.

Jaki token:

- **Fine-grained personal access token.** Dostęp do repozytoriów, które będą synchronizowane (w tym do `szambiarka-pl/.github`, jeśli etykiety mają tu powstać). Uprawnienie repozytorium: **Issues: Read and write**. Metadata: Read GitHub dodaje przy tym sam.
- **Classic personal access token.** Zakres **`repo`**. To repozytorium jest prywatne, a etykiety w prywatnym repozytorium wymagają tego zakresu.

Zamiast sekretu repozytorium może być sekret organizacji o tej samej nazwie `LABELS_SYNC_TOKEN`, udostępniony temu repozytorium. Token nie wchodzi do gita. Osoba z prawem zapisu może uruchomić workflow dla dowolnej nazwy w organizacji, dlatego token powinien obejmować tylko te repozytoria, w których synchronizacja etykiet jest zamierzona.

### Uruchomienie

1. Dodaj sekret `LABELS_SYNC_TOKEN`.
2. Po zmergowaniu do `main` otwórz **Actions** → **Synchronizacja etykiet** → **Run workflow**.
3. W polu nazwy repozytorium wpisz na przykład `.github`, a osobnym uruchomieniem `szambiarka`.
4. W logu widać, która etykieta została utworzona, a która tylko zaktualizowana. Na końcu jest liczba jednych i drugich.
