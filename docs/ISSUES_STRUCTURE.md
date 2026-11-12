# Issues treści SEO — struktura do akceptacji

Projekt kolejki epików i sub-issues dla bota Szambiarka Copywriter. Issues i etykiety **nie są** założone na GitHubie. Kod `szambiarka-pl/szambiarka` **nie jest** ruszany (blokada soft-open).

Szablony z katalogu `ISSUE_TEMPLATE/` są przygotowane pod przyszłe repo organizacji `szambiarka-pl/.github`. Dziś go nie ma. W `szambiarka` nie ma `.github/ISSUE_TEMPLATE` (jest szablon PR, Copilot i workflow). Etykiety repo to domyślne GitHuba, Dependabot i `run-e2e`. Zestaw z `labels.json` ich nie nadpisuje.

## Czym jest serwis w tych issue

Szambiarka.pl jest pośrednikiem między właścicielem zbiornika bezodpływowego lub przydomowej oczyszczalni a firmą asenizacyjną. Nie wykonuje wywozu, nie przyjmuje płatności za wywóz i nie wystawia dokumentu za usługę. Firmy ustalają ceny, bez abonamentu. Trwa soft-open: zamówienia zamknięte. CTA klienta to `https://szambiarka.pl/powiadom-mnie`, CTA firmy to `https://szambiarka.pl/firma`.

## Skąd wzięły się URL-e

Źródło prawdy to kod i korpus, nie arkusz agencji.

| Źródło | Co z niego bierzemy |
| --- | --- |
| `apps/landing-page/app/sitemap.ts` | Strony statyczne, hub poradnika, kubełki województw |
| `apps/landing-page/lib/seo/final.db` | Eksport `2026-09-05 20:22:04`, 2532 wiersze `final_content`: 16 województw (L2), 2479 stron L3 (2177 `gmina-*`, 302 `miasto-*`), 37 stron L4 |
| `apps/landing-page/lib/seo/placeDirectory.ts` | Katalog HTML po 250 pozycji: `/gminy/1`–`/gminy/9`, `/miasta/1`–`/miasta/2` |
| `apps/landing-page/content/poradnik/*.mdx` | 22 artykuły. Kategoria bez artykułu nie ma strony (`technologie-i-innowacje` przekierowuje na hub) |
| `apps/landing-page/docs/wiki/concepts/seo-knowledge-base.md` | Właściciele fraz |
| `data-pipeline/enrichment/writer-brief.md` | Sekcje strony lokalnej i zakaz kwot spoza karty faktów |
| `apps/landing-page/docs/seo-sources/agencja-2025-2026/content-plan-poradnika.md` | 87 tematów. Stan TODO w arkuszu bywa nieaktualny: plik MDX już jest |

Rozjazd do zapamiętania: baza wiedzy podaje H1 cennika „Jedna cena.”. W kodzie (`app/cennik/page.tsx`) H1 to „Cennik wywozu szamba {rok} — stawki firm asenizacyjnych”. Issue startuje od kodu.

Nie ma osobnych URL-i `/faq`, `/uslugi`, `/blog`, `/uslugi-asenizacyjne`, `/wywoz-szamba-24h`. FAQ jest sekcją strony. Słownik jest kategorią `/poradnik/slownik`, nie osobnym serwisem.

## Decyzja Bartka o frazie głównej

Fraza `wywóz szamba` bez nazwy miejsca ma właściciela `https://szambiarka.pl/wywoz-szamba` (E02). Strona główna `/` opiera się na klastrze marki (`szambiarka`, `szambiarka.pl`, `szambiarka pl`).

W bazie wiedzy SEO wiersz mapy fraz nadal oddaje head stronie głównej. Ta kolejka idzie za decyzją Bartka. Kodu nikt przy tej zmianie nie rusza: żywy tytuł `/` w `lib/seo/homeMetadata.ts` nadal brzmi „Wywóz szamba - zamów online w całej Polsce | Szambiarka.pl”. Issue E01 ma ustalić tekst pod markę. Issue E02 ma utrzymać head na katalogu.

## Liczby

18 epików, **131 sub-issues**. 2177 gmin i 302 miast nie dostają osobnego issue.

| Fala | Priorytet | Sub-issues | Co wchodzi |
| --- | ---: | ---: | --- |
| 1 | P0 | 8 | `/`, `/wywoz-szamba`, `/cennik`, 4 filary poradnika, `/firma` |
| 2 | P1 | 40 | 5 szablonów lokalnych, 16 województw, 16 paczek gmin, 1 audyt miast, 2 decyzje E4 |
| 3 | P2 | 60 | hub i 3 kategorie, 18 opublikowanych artykułów poza filarami, `/firma/rejestracja`, 37 stron L4 |
| 4 | P3 | 23 | 15 propozycji nowych artykułów, 5 decyzji o URL, 3 strony konwersji |
| | | **131** | |

Paczka gmin to jedno issue na województwo: kontrakt unikalnych sekcji i trzy próbki. Tekst 2177 stron zostaje w `final.db`. Wklejenie korpusu do issues przekracza sens kolejki i limit treści issue.

## Kolejność pracy

1. Fala 1. Pełny tekst w sub-issue, review, akceptacja Bartka i Product Ownera. Kod stoi.
2. Fala 2. Najpierw szablony sekcji (E09), potem 16 stron województw (E10), potem 16 paczek gmin (E11), na końcu audyt miast (E12). Decyzje E4 (osobna strona usług, osobna strona 24h) idą równolegle z falą 2, zanim ktokolwiek pisze nowy URL.
3. Fala 3. Istniejące artykuły i huby oraz 37 adresów L4. Umowa na wywóz zostaje z etykietą `flaga: zamrozone`.
4. Fala 4. Nowy artykuł dopiero wtedy, gdy właściciel pokrewnej frazy jest już zaakceptowany i decyzja w E17 mówi, że URL ma powstać.

## Epiki i sub-issues

Identyfikator zostaje na stałe. Tytuł issue na GitHubie: `epik: …` albo `treść: …`.

### E01 Strona główna — P0 — 1 — `obszar: home`

Klaster marki: `szambiarka`, `szambiarka.pl`, `szambiarka pl`. Fraza `wywóz szamba` należy do E02. Tytuł w kodzie jest absolutny i ten sam przy zamkniętych i otwartych zamówieniach: „Wywóz szamba - zamów online w całej Polsce | Szambiarka.pl” (58 znaków, `lib/seo/homeMetadata.ts`). H1 przy zamkniętych zamówieniach: „Wywóz szamba. Startujemy rejon po rejonie.” FAQ jest tablicą `faq` w `app/page.tsx`. Szkic E01 przestawia tytuł, H1 i opis na markę. Słowa o wywozie mogą zostać w treści jako opis serwisu, z linkiem do katalogu, i nie są frazą, pod którą strona ma rankować.

| Id | URL | Fraza główna |
| --- | --- | --- |
| E01-01 | `https://szambiarka.pl/` | szambiarka / szambiarka.pl |

Poza epikiem: `wywóz szamba` bez miejsca (E02), `wywóz szamba {miejsce}` (L3/L4), definicja asenizacji, karty cen (`/cennik`), wyjaśnienie skąd się bierze cena (artykuł).

### E02 Katalog usług — P0 — 1 — `obszar: uslugi`

Właściciel frazy `wywóz szamba` bez miejscowości oraz krajowej frazy `usługi asenizacyjne`. Jeden URL na obie, bez drugiej strony komercyjnej. Tytuł w kodzie: „Wywóz szamba i usługi asenizacyjne w Polsce”.

| Id | URL | Fraza główna |
| --- | --- | --- |
| E02-01 | `https://szambiarka.pl/wywoz-szamba` | wywóz szamba |

Poza epikiem: marka (E01), `wywóz szamba {miejsce}` (L3/L4 i województwo na E10), definicja „asenizacja co to” (E04). Osobnej strony „usługi asenizacyjne” nie ma — decyzja E17-02.

### E03 Cennik — P0 — 1 — `obszar: cennik`

Intencja transakcyjna. Wyjaśnienie „ile kosztuje” jest artykułem E04-03, nie drugą wersją tej strony.

| Id | URL |
| --- | --- |
| E03-01 | `https://szambiarka.pl/cennik` |

Kwoty na stronie biorą się z `lib/pricing.ts` (`PRICE_TIERS`). To issue nie dopisuje własnych stawek.

### E04 Filary poradnika — P0 — 4 — `obszar: poradnik` / `obszar: slownik`

Właściciele intencji z kontraktu SEO. Praca fali 1 to pełny tekst w issue i akceptacja, nie nowy slug.

| Id | URL | Fraza główna | Uwaga |
| --- | --- | --- | --- |
| E04-01 | `/poradnik/co-to-jest-szambo-jak-dziala` | szambo (definicja) | Kategoria `slownik`. Plan agencji nr 1 |
| E04-02 | `/poradnik/co-to-jest-asenizacja` | asenizacja (definicja) | Plan nr 2. Intencja komercyjna „usługi asenizacyjne” zostaje przy E02 |
| E04-03 | `/poradnik/ile-kosztuje-wywoz-szamba-2026` | ile kosztuje wywóz szamba | Plan nr 16. Rok w tytule, nie w nowym slugu. Karty cen zostają na `/cennik` |
| E04-04 | `/poradnik/umowa-na-wywoz-szamba` | umowa na wywóz szamba | Plan nr 5. Etykieta `flaga: zamrozone`. Baza wiedzy: pozycje 1–3, strony nie przepisywać bez nowego przepisu |

### E05 Strony dla firm — 2 — `obszar: firmy`

Decyzja z 6.02.2026 stawia firmy przed klientami, dlatego `/firma` jest w fali 1. `/firmy/{kod}` pisze sama firma. Regulaminy są `noindex` i zostają u prawnika.

| Id | Priorytet | URL |
| --- | --- | --- |
| E05-01 | P0 | `https://szambiarka.pl/firma` |
| E05-02 | P2 | `https://szambiarka.pl/firma/rejestracja` |

H1 w kodzie: „Dodatkowe wywozy w Twoim rejonie.” Tekst ma utrzymać „bez abonamentu” i „klient płaci firmie”.

### E06 Hub poradnika — P2 — 4 — `obszar: poradnik`

| Id | URL | Co to jest |
| --- | --- | --- |
| E06-01 | `/poradnik` | Hub. Tytuł: „Poradnik — wywóz szamba i przepisy”. H1: „Wywóz szamba bez niewiadomych” |
| E06-02 | `/poradnik/eksploatacja` | Kategoria, ma artykuły |
| E06-03 | `/poradnik/przepisy-i-formalnosci` | Kategoria, ma artykuły |
| E06-04 | `/poradnik/slownik` | Kategoria „Słownik pojęć”, ma dwa filary z E04 |

`/poradnik/technologie-i-innowacje` nie jest issue. Kategoria pusta nie ma strony. Wróci razem z decyzją E17-05, jeśli czujnik napełnienia dostanie artykuł.

### E07 Przepisy i formalności — opublikowane — P2 — 12 — `obszar: poradnik`

Umowa jest w E04, nie tutaj. Każdy wiersz to istniejący plik MDX. Etykieta `flaga: prawne`. Plan agencji przy części z nich nadal mówi TODO — plik jest nowszy niż arkusz.

| Id | Slug | Plan | Tytuł w pliku |
| --- | --- | --- | --- |
| E07-01 | `kto-odpowiada-za-wywoz-szamba` | 4 | Kto odpowiada za wywóz szamba – jakie są obowiązki właścicieli szamb? |
| E07-02 | `wywoz-szamba-przepisy-ustawa` | 6 | Wywóz szamba a przepisy – jaka ustawa i przepisy regulują wywóz nieczystości? |
| E07-03 | `jednorazowy-wywoz-szamba` | 7 | Jednorazowy wywóz szamba – czy jest możliwy i wymaga umowy? |
| E07-04 | `jak-krok-po-kroku-zamowic-wywoz-szamba` | 8 | Jak krok po kroku zamówić wywóz szamba? |
| E07-05 | `jak-wybrac-firme-asenizacyjna` | 9 | Jak wybrać odpowiednią firmę asenizacyjną do wywozu szamba? |
| E07-06 | `nie-oproznianie-szamba-jakie-kary` | 10 | Kara za brak wywozu szamba — mandat i jak jej uniknąć |
| E07-07 | `brak-szamba-na-posesji-jakie-kary` | 11 | Brak szamba na posesji — jaka kara i co zrobić? |
| E07-08 | `kara-za-nielegalne-wylewanie-szamba` | 12 | Jaka jest kara za nielegalne wylewanie szamba do gleby? |
| E07-09 | `kontrola-gminy-dokumenty-kary` | 3 | Kontrola szamba z gminy — jakie dokumenty okazać |
| E07-10 | `kontrola-szczelnosci-szamba` | 13 | Kontrola szczelności szamba – kto i kiedy sprawdza szczelność zbiorników bezodpływowych? |
| E07-11 | `zgloszenie-szamba-do-ewidencji-gminy` | 15 | Ewidencja szamb w gminie — czy trzeba zgłosić szambo? |
| E07-12 | `brak-rachunkow-za-wywoz-szamba` | 14 | Brak rachunków za wywóz szamba – co grozi i co zrobić? |

Adres: `https://szambiarka.pl/poradnik/{slug}`.

### E08 Eksploatacja — opublikowane — P2 — 6 — `obszar: poradnik`

Artykuł cenowy jest filarem E04-03.

| Id | Slug | Plan | Tytuł w pliku |
| --- | --- | --- | --- |
| E08-01 | `jak-czesto-oprozniac-szambo` | 17 | Jak często opróżniać szambo? Kompletny poradnik z tabelą i wzorem |
| E08-02 | `jak-czesto-oprozniac-szambo-ekologiczne` | 19 | Jak często opróżniać szambo ekologiczne? |
| E08-03 | `jak-rzadziej-oprozniac-szambo` | 21 | Jak rzadziej opróżniać szambo - 6 sposobów na zmniejszenie ilości ścieków |
| E08-04 | `pelne-szambo-co-robic` | 18 | Pełne lub przelewające się szambo – co robić w awaryjnych sytuacjach? Jakie są konsekwencje? |
| E08-05 | `dlaczego-szambo-jest-pelne-wody` | 87 | Dlaczego w szambie stoi woda? Najczęstsze błędy i jak ich uniknąć |
| E08-06 | `szambo-a-przydomowa-oczyszczalnia` | 77 | Szambo a przydomowa oczyszczalnia — koszty i przepisy |

### E09 Szablon stron lokalnych — P1 — 5 — `typ: szablon` — `obszar: lokalne`

To jest fala „szablon z unikalnymi sekcjami”, zanim ktokolwiek ruszy korpus. Sekcje biorą się z `writer-brief.md` i z pól `metadata` w `final.db`: `population`, `population_sewered`, `population_unsewered`, `unsewered_share_pct`, `septic_tanks`, `household_plants`, `liquid_waste_m3`, `dumping_stations`, `stats_year`.

| Id | Szablon | Dotyczy |
| --- | --- | --- |
| E09-01 | L2 województwo | 16 URL-i E10 |
| E09-02 | L3 gmina | 2177 URL-i, paczki E11. Słowo „gmina”. FAQ: 3 fakty tej gminy |
| E09-03 | L3 miasto | 302 URL-i, audyt E12. Słowo „miasto”, nigdy „gmina”. Bez listy dzielnic |
| E09-04 | L4 dzielnica albo osiedle | 37 URL-i E13. Warszawa: dzielnica. Wrocław i Gdańsk: osiedle, tak jak brief |
| E09-05 | Katalog HTML | `/gminy/1`–`/gminy/9`, `/miasta/1`–`/miasta/2`. Lista linków, nie esej |

Wspólny kontrakt sekcji, każda sekcja odpada, gdy karta faktów jej nie uniesie:

1. **Uwaga.** Pierwsze zdanie: miejsce i usługa, fraza `wywóz szamba {miejsce}`.
2. **Zainteresowanie.** Liczby BDL z roku na karcie. Brak liczb = brak sekcji.
3. **Stacje zlewne.** Tylko `dumping_stations` (BDL 290440). Bot Stacje Zlewne dopowiada fakt, gdy pole jest na karcie. Liczba stacji nie jest zapewnieniem o legalności wywozu.
4. **Zasięg.** Miejscowości i sąsiedzi z karty, link do województwa. Zakres strony to adresy w granicach tej jednostki. To nie jest obietnica, że firma dojedzie wszędzie.
5. **Działanie.** Zapis na start (`/powiadom-mnie`) z kontekstem miejsca. Bez czasu dojazdu i bez liczby firm.
6. **FAQ.** Trzy pytania z faktów tej strony. Pytania o umowę, kary, częstotliwość i cenę w złotych zostają przy E04 i E07.

Linki wewnętrzne strony lokalnej zostają w grafie miejsc. Anchory: `wywóz szamba {nazwa}`.

### E10 Województwa — P1 — 16 — `obszar: lokalne`

Pełny tekst w issue. Jeden URL, jeden issue. Adres: `https://szambiarka.pl/wywoz-szamba/{slug}`.

| Id | Slug | Nazwa w korpusie | Gmin w E11 | Miast w E12 |
| --- | --- | --- | ---: | ---: |
| E10-01 | `dolnoslaskie` | dolnośląskie | 134 | 35 |
| E10-02 | `kujawsko-pomorskie` | kujawsko-pomorskie | 127 | 17 |
| E10-03 | `lodzkie` | łódzkie | 159 | 18 |
| E10-04 | `lubelskie` | lubelskie | 193 | 20 |
| E10-05 | `lubuskie` | lubuskie | 73 | 9 |
| E10-06 | `malopolskie` | małopolskie | 169 | 14 |
| E10-07 | `mazowieckie` | mazowieckie | 279 | 35 |
| E10-08 | `opolskie` | opolskie | 68 | 3 |
| E10-09 | `podkarpackie` | podkarpackie | 144 | 16 |
| E10-10 | `podlaskie` | podlaskie | 106 | 13 |
| E10-11 | `pomorskie` | pomorskie | 101 | 22 |
| E10-12 | `slaskie` | śląskie | 118 | 49 |
| E10-13 | `swietokrzyskie` | świętokrzyskie | 97 | 5 |
| E10-14 | `warminsko-mazurskie` | warmińsko-mazurskie | 100 | 16 |
| E10-15 | `wielkopolskie` | wielkopolskie | 207 | 19 |
| E10-16 | `zachodniopomorskie` | zachodniopomorskie | 102 | 11 |

Suma kontrolna: 2177 gmin i 302 miasta.

### E11 Gminy — unikalne sekcje — P1 — 16 — `obszar: lokalne`

Jedno issue na województwo, nie jedno na gminę. Tytuł: „Gminy {województwo} — unikalne sekcje”. W treści: kontrakt E09-02, liczba URL-i z tabeli E10 i trzy próbki z tego województwa (karta z liczbami BDL, karta typowa, karta bez części liczb). Kryterium akceptacji próbki: po zdjęciu nazwy i liczb tekst nie jest kopią innej gminy. Źródło tekstu produkcyjnego zostaje `final.db`. Regeneracja całego korpusu naraz jest osobną decyzją, nie częścią tego issue.

Ta sama kolejność co E10. W issue są próbki, nie 2177 tekstów.

| Id | Slug | URL-i `gmina-*` |
| --- | --- | ---: |
| E11-01 | `dolnoslaskie` | 134 |
| E11-02 | `kujawsko-pomorskie` | 127 |
| E11-03 | `lodzkie` | 159 |
| E11-04 | `lubelskie` | 193 |
| E11-05 | `lubuskie` | 73 |
| E11-06 | `malopolskie` | 169 |
| E11-07 | `mazowieckie` | 279 |
| E11-08 | `opolskie` | 68 |
| E11-09 | `podkarpackie` | 144 |
| E11-10 | `podlaskie` | 106 |
| E11-11 | `pomorskie` | 101 |
| E11-12 | `slaskie` | 118 |
| E11-13 | `swietokrzyskie` | 97 |
| E11-14 | `warminsko-mazurskie` | 100 |
| E11-15 | `wielkopolskie` | 207 |
| E11-16 | `zachodniopomorskie` | 102 |

### E12 Miasta — audyt szablonu — P1 — 1 — `obszar: lokalne`

| Id | Zakres |
| --- | --- |
| E12-01 | 302 adresy `…/miasto-*`. Jedno issue audytu szablonu E09-03, nie 302 esejów |

Miasta wygrywają tytułem i linkiem. Osobne eseje dla Warszawy, Wrocławia i Gdańska były i zostały zdjęte. Ten audyt ich nie przywraca. Dzielnice tych trzech miast są w E13.

### E13 Dzielnice i osiedla — P2 — 37 — `obszar: lokalne`

Pełny tekst w issue, krótki: karta L4 ma lokalizację, bez liczb BDL gminy-matki (nie przypisujemy ich dzielnicy). Adres: `https://szambiarka.pl/wywoz-szamba{slug}`.

**Wrocław — osiedla**

| Id | Slug |
| --- | --- |
| E13-01 | `/dolnoslaskie/miasto-wroclaw/jagodno` |
| E13-02 | `/dolnoslaskie/miasto-wroclaw/lipa-piotrowska` |
| E13-03 | `/dolnoslaskie/miasto-wroclaw/oltaszyn` |
| E13-04 | `/dolnoslaskie/miasto-wroclaw/pracze-odrzanskie` |
| E13-05 | `/dolnoslaskie/miasto-wroclaw/strachocin` |
| E13-06 | `/dolnoslaskie/miasto-wroclaw/swojczyce` |
| E13-07 | `/dolnoslaskie/miasto-wroclaw/widawa` |
| E13-08 | `/dolnoslaskie/miasto-wroclaw/wojnow` |

**Gdańsk — osiedla**

| Id | Slug |
| --- | --- |
| E13-09 | `/pomorskie/miasto-gdansk/jasien` |
| E13-10 | `/pomorskie/miasto-gdansk/kokoszki` |
| E13-11 | `/pomorskie/miasto-gdansk/lipce` |
| E13-12 | `/pomorskie/miasto-gdansk/matarnia` |
| E13-13 | `/pomorskie/miasto-gdansk/olszynka` |
| E13-14 | `/pomorskie/miasto-gdansk/orunia` |
| E13-15 | `/pomorskie/miasto-gdansk/osowa` |
| E13-16 | `/pomorskie/miasto-gdansk/sobieszewo` |

**Warszawa — 18 dzielnic TERYT i 3 osiedla z korpusu** (Anin, Choszczówka, Falenica)

| Id | Slug | Nazwa |
| --- | --- | --- |
| E13-17 | `/mazowieckie/miasto-warszawa/anin` | Anin |
| E13-18 | `/mazowieckie/miasto-warszawa/bemowo` | Bemowo |
| E13-19 | `/mazowieckie/miasto-warszawa/bialoleka` | Białołęka |
| E13-20 | `/mazowieckie/miasto-warszawa/bielany` | Bielany |
| E13-21 | `/mazowieckie/miasto-warszawa/choszczowka` | Choszczówka |
| E13-22 | `/mazowieckie/miasto-warszawa/falenica` | Falenica |
| E13-23 | `/mazowieckie/miasto-warszawa/mokotow` | Mokotów |
| E13-24 | `/mazowieckie/miasto-warszawa/ochota` | Ochota |
| E13-25 | `/mazowieckie/miasto-warszawa/praga-polnoc` | Praga-Północ |
| E13-26 | `/mazowieckie/miasto-warszawa/praga-poludnie` | Praga-Południe |
| E13-27 | `/mazowieckie/miasto-warszawa/rembertow` | Rembertów |
| E13-28 | `/mazowieckie/miasto-warszawa/srodmiescie` | Śródmieście |
| E13-29 | `/mazowieckie/miasto-warszawa/targowek` | Targówek |
| E13-30 | `/mazowieckie/miasto-warszawa/ursus` | Ursus |
| E13-31 | `/mazowieckie/miasto-warszawa/ursynow` | Ursynów |
| E13-32 | `/mazowieckie/miasto-warszawa/wawer` | Wawer |
| E13-33 | `/mazowieckie/miasto-warszawa/wesola` | Wesoła |
| E13-34 | `/mazowieckie/miasto-warszawa/wilanow` | Wilanów |
| E13-35 | `/mazowieckie/miasto-warszawa/wlochy` | Włochy |
| E13-36 | `/mazowieckie/miasto-warszawa/wola` | Wola |
| E13-37 | `/mazowieckie/miasto-warszawa/zoliborz` | Żoliborz |

Strona miasta nie wylicza tych nazw. Każdy wiersz jest właścicielem własnej frazy `wywóz szamba {nazwa}`.

### E14 Nowe klastry eksploatacji — P3 — 7 — `typ: artykul`

URL **nie istnieje**. Szkic startuje po akceptacji pokrewnego artykułu z E08 i po odpowiedzi E17, gdzie zaznaczono. Slugów tu nie ma celowo.

| Id | Tytuł roboczy | Tematy planu | Pokrewny URL, którego nie dublować |
| --- | --- | --- | --- |
| E14-01 | Zapach, opary i gazy | 23, 27, 39 | — |
| E14-02 | Szambo zimą i latem | 25, 30 | jeden artykuł na dwa sezony |
| E14-03 | Jak dbać o szambo | 24, 67 jako sekcja | 67 bez kwot. Częstotliwość zostaje przy E08-01 |
| E14-04 | Jak sprawdzić, czy szambo jest pełne | 26 | E08-04 jest o awarii, nie o pomiarze |
| E14-05 | Długość węża i zasięg wozu | 31 | Serwis nie ma własnego wozu. Tekst opisuje, o co pytać firmę |
| E14-06 | Czyszczenie szamba | 63, 64, 65 | jeden artykuł, nie trzy |
| E14-07 | Wywóz osadu z przydomowej oczyszczalni | 29, 59 jako sekcja | E08-02 jest o częstotliwości, nie o procedurze osadu |

### E15 Nowe klastry formalności — P3 — 5 — `flaga: prawne`

| Id | Tytuł roboczy | Tematy planu | Uwaga |
| --- | --- | --- | --- |
| E15-01 | Szambo na działce ROD | 32, 34 | jeden URL |
| E15-02 | Budowa szamba — pozwolenie, zgłoszenie, odległości | 33, 70, 71, 72, 75, 81, 82 | Temat 73 (cena budowy) bez kwot: nie mamy źródła |
| E15-03 | Likwidacja szamba | 40 | przepis albo brak zdania |
| E15-04 | Wymiana i remont szamba | 61, 62 | jeden URL |
| E15-05 | Zmiana szamba na oczyszczalnię | 78, 79 | Porównanie „szambo czy oczyszczalnia” zostaje przy E08-06 |

### E16 Słownik — nowe hasła — P3 — 3 — `obszar: slownik`

| Id | Tytuł roboczy | Tematy planu | Uwaga |
| --- | --- | --- | --- |
| E16-01 | Rodzaje szamb | 41–49, 53, 74, 80 | Jeden artykuł. 46 i 47 linkują do E08-02 i E08-06 zamiast budować własne definicje |
| E16-02 | Rodzaje ścieków | 54, 55, 56, 57 | Bytowe, przemysłowe, komunalne jako sekcje |
| E16-03 | Osadnik gnilny i wtórny | 58, 60 | Odbiór osadu zostaje przy E14-07 |

### E17 Decyzje o URL — `typ: decyzja`

Bez szkicu strony. Odpowiedź Bartka zamyka issue. Rekomendacja jest propozycją, nie decyzją.

| Id | Priorytet | Pytanie | Rekomendacja |
| --- | --- | --- | --- |
| E17-01 | P1 | Czy powstaje URL pod „24h” / pogotowie asenizacyjne (plan 28, epik E4 w bazie wiedzy)? | Nie w tej kolejce. Obietnica przyjazdu byłaby nieprawdą. Awaria ma właściciela: E08-04 |
| E17-02 | P1 | Czy powstaje osobna strona „usługi asenizacyjne” obok katalogu? | Nie. Head `wywóz szamba` i krajowe usługi asenizacyjne ma E02, definicja ma E04-02 |
| E17-03 | P3 | „Szambo czy kanalizacja” (plan 52) jako osobny URL? | Sekcja E08-06, chyba że Baza Wiedzy pokaże inną intencję niż porównanie z oczyszczalnią |
| E17-04 | P3 | „Bakterie do szamba” (plan 50) jako osobny URL? | Sekcja E08-03, dopóki fraza nie ma własnego popytu |
| E17-05 | P3 | Czujnik napełnienia (plan 84). Skutek uboczny: powstałaby kategoria technologie | Zostawić kategorię pustą, bez strony |
| E17-06 | P3 | Ukrycie włazu (plan 83) | Nie zakładać bez popytu z Bazy Wiedzy |
| E17-07 | P3 | Hub „najczęstsze problemy z szambem” (plan 22) | Nie zakładać. Hub zjadłby E08 i E14. Spis linków może żyć na E06-01 |

### E18 Strony konwersji — P3 — 3 — `obszar: konwersja`

Są w sitemapie. Krótki tekst, nie artykuł.

| Id | URL |
| --- | --- |
| E18-01 | `https://szambiarka.pl/kontakt` |
| E18-02 | `https://szambiarka.pl/powiadom-mnie` |
| E18-03 | `https://szambiarka.pl/newsletter` |

## Tematy planu, które nie dostają issue

Zostają sekcją właściciela albo są już opublikowane pod innym adresem. Etykieta logiczna: `flaga: nie-tworzyc-url`.

| Plan | Temat | Gdzie ląduje |
| --- | --- | --- |
| 20 | Szczelność szamba, drugi raz obok planu 13 | E07-10 |
| 35 | Ile trwa opróżnianie | sekcja E07-04 |
| 36 | Roczne koszty szamba i oczyszczalni | zablokowane. Brak źródła na koszt roczny. Nie dopisywać liczb do E08-06 |
| 37 | Gdzie zgłosić nielegalne wylewanie | sekcja E07-08 |
| 38 | Kiedy nie można mieć oczyszczalni | sekcja E08-06 |
| 51 | Szambo betonowe a wody gruntowe | sekcja E08-05 |
| 66 | Jak uszczelnić szambo | sekcja E07-10 |
| 68 | Wpływ szamba na środowisko | sekcja E04-01 |
| 69 | Pojemność szamba | sekcja E08-01 |
| 76 | Przydomowa oczyszczalnia a szambo ekologiczne | E08-02 i E08-06, bez trzeciego URL |
| 85 | Kontrole, dokumenty i kary 2026 | już scalone do E07-09. Stary slug przekierowany |
| 86 | Ceny wywozu w Warszawie | już scalone do E04-03. Bez strony cenowej miasta |

## Poza kolejką treści

`noindex` albo ścieżka produktu, nie esej SEO:

- `/zamow`, `/zamowienie/{id}`, `/zlecenie/{token}`, `/logowanie`, `/ocen-zamowienie`, `/potwierdz-email`, `/odstapienie`, `/pomin-termin`, `/wkrotce`, `/prototyp-wyszukiwarka`
- potwierdzenia i wypisania `/powiadom-mnie/…` oraz `/newsletter/…`
- `/regulamin`, `/polityka-prywatnosci`, ich archiwa, `/regulamin-dla-firm`, `/regulamin-zapytan`
- `/firmy/{kod}` oraz regulamin i polityka firmy

## Jeden klaster, jeden URL

Reguły operacyjne. Punkt 1 i 6 są decyzją Bartka dla tej kolejki i są nowsze niż wiersz mapy fraz w bazie wiedzy.

1. `wywóz szamba` bez miejsca → `/wywoz-szamba` (E02). Strona główna tego klastra nie bierze.
2. `wywóz szamba {miejsce}` → dokładnie ten L3 albo L4. W tytule i H1 nie ma „i okolice”. Województwo bierze tylko `wywóz szamba {województwo}`.
3. Definicja asenizacji → E04-02. Krajowe `usługi asenizacyjne` siedzą na tym samym URL co head, czyli E02. Wariant z województwem lub gminą → E10/E11.
4. Karty cen → `/cennik`. Wyjaśnienie, skąd cena → E04-03. Strona gminy nie dostaje drugiej tabeli cen ani kwoty spoza karty.
5. Umowa, kontrole, kary, ewidencja, rachunki → istniejące slugi E04 i E07. Klon tematu jest błędem kolejki.
6. Marka `szambiarka`, `szambiarka.pl`, `szambiarka pl` → strona główna (E01). To jest jej klaster. Strona gminy i katalog jej nie optymalizują.
7. Synonimy (`opróżnianie szamba`, `wywóz nieczystości płynnych`, `odbiór szamba`) są frazami wspierającymi E02. Własnego URL nie dostają i na stronie głównej nie są frazą główną.
8. Rok zostaje w tytule artykułu cenowego. Nowy rok nie tworzy nowego slugu.
9. Pusta kategoria poradnika nie dostaje strony.
10. Nowy URL jest ostatni: po akceptacji właściciela pokrewnej frazy i po issue typu decyzja.

## Workstream

Stan issue jest kolumną projektu, nie etykietą. Etykieta statusu rozjechałaby się z tablicą.

| Etap | Kto | Co powstaje | Wejście do następnego etapu |
| --- | --- | --- | --- |
| Brief | Bot Baza Wiedzy SEO. Przy stronach lokalnych także karta z `final.db`. Bot Stacje Zlewne tylko gdy na karcie jest `dumping_stations` | Fraza główna, frazy wspierające, intencja, właściciel URL, pytania FAQ, źródła, lista rzeczy niepotwierdzonych | URL i fraza nie kolidują z innym issue. Przy braku faktu zdanie ląduje w „niepotwierdzone”, nie w szkicu |
| Szkic | Bot Szambiarka Copywriter | Pełny tekst, H1, meta title, meta description, FAQ, linki, CTA, opis grafik i tabel | Checklista treści uzupełniona. CTA zgodne z soft-openem |
| Review SEO | Rola On-page | Kontrola długości meta, jednego H1, linków, zgodności FAQ ze schema, kanibalizacji, braku obietnic floty | Uwagi wpisane w komentarzu. Brak uwagi albo poprawiony szkic |
| Do akceptacji | Bartek i Product Owner, równolegle | Czytają tekst w issue. Przy `flaga: prawne` akceptacja obejmuje cytaty. Przy cenach akceptacja obejmuje źródło kwot | Oba pola „Akceptacja” = tak |
| Zaakceptowane | Nikt nie dopisuje zdań | Tekst zamrożony. Bot Facebook Posty może napisać zajawkę | Zajawka nie blokuje tego etapu |
| Gotowe do wdrożenia | Bartek, słowem, po zdjęciu blokady soft-open | Issue wolno wziąć do kodu (MDX, korpus, komponent strony) | Osobna praca inżynierska. Ten projekt jej nie otwiera |
| Wdrożone | Po wydaniu tekstu | Link do zmiany w repo | — |
| Zablokowane | Ktokolwiek, z komentarzem | Flaga: kanibalizacja, brak faktów, decyzja, prawne | Wróci na Brief, gdy brak uzupełniony |

**Definicja ukończenia tekstu.** Issue jest skończone na etapie Zaakceptowane: pełny tekst, checklista, dwie akceptacje, puste „niepotwierdzone” albo lista zdań świadomie wyciętych, jeden właściciel frazy, CTA soft-open. Wdrożenie na produkcję jest osobnym końcem i w trakcie blokady nie następuje.

**Zajawki.** Bot Facebook Posty startuje po Zaakceptowane. Pisze zajawkę w komentarzu tego samego issue i ustawia pole „Zajawka FB”. Linkuje kanoniczny URL. Nie zakłada posta jako drugiego artykułu pod tę samą frazę.

**On-page** nie edytuje kodu produktu w trakcie blokady. Sprawdza tekst w issue.

**Stacje zlewne** nie piszą akapitów o „legalnym odbiorze”. Dostarczają fakt stacji albo milczą, gdy pola nie ma.

## GitHub Project

Nazwa: **Treści SEO**. Repo: `szambiarka-pl/szambiarka`. Epik jest rodzicem sub-issues (wbudowane sub-issues GitHuba).

Widoki:

- Tablica **Praca**, grupowanie po Status.
- Tablica **Fala P0**, filtr Priorytet = P0.
- Tabela **Epiki**, grupowanie po Epik.
- Tabela **Blokady**, filtr Blokada ≠ brak.

Pola:

| Pole | Typ | Wartości |
| --- | --- | --- |
| Status | single select | Brief, Szkic, Review SEO, Do akceptacji, Zaakceptowane, Gotowe do wdrożenia, Wdrożone, Zablokowane |
| Priorytet | single select | P0, P1, P2, P3 |
| Epik | single select | E01–E18 |
| Typ strony | single select | jak w formularzu |
| Fraza główna | text | |
| URL | text | |
| Akceptacja Bartek | single select | czeka, tak, uwagi |
| Akceptacja PO | single select | czeka, tak, uwagi |
| Zajawka FB | single select | nie dotyczy, do napisania, gotowa |
| Blokada | single select | brak, kanibalizacja, brak faktów, decyzja, prawne |
| Źródło | text | GUS BDL, stacje, przepis, pricing.ts, dataset artykułu |

Kolumny tablicy = wartości Status, w tej kolejności.

## Etykiety

Plik `labels.json`. Opis mieści się w limicie 100 znaków GitHuba. Statusu nie ma wśród etykiet.

Istniejące etykiety (`bug`, `documentation`, `question`, `run-e2e` i reszta) zostają przy kodzie. Treści SEO ich nie używają. `documentation` znaczy w tym repo dokumentację techniczną, nie artykuł na szambiarka.pl.

## Formularze

| Plik | Issue |
| --- | --- |
| `ISSUE_TEMPLATE/epic-tresci.yml` | Epik |
| `ISSUE_TEMPLATE/strona-artykul.yml` | Strona, artykuł, szablon, decyzja |
| `ISSUE_TEMPLATE/config.yml` | `blank_issues_enabled: true` i linki do mapy fraz, planu, briefu i rejestru decyzji |

`blank_issues_enabled` zostaje włączone. Szablony w org `.github` staną się domyślne także dla `szambiarka`, które własnego `ISSUE_TEMPLATE` nie ma. Wyłączenie pustych issues zabrałoby zwykłe zgłoszenia błędów.

Pola treści w formularzu strony są opcjonalne przy otwarciu (etap Brief). Checklista akceptacji jest w formularzu, bez `required`, żeby dało się założyć issue zanim tekst istnieje. Obowiązkowa staje się operacyjnie przy wejściu w Zaakceptowane.

## Pytania do Bartka

1. Czy Product Owner to osobna osoba? Kto ustawia „Akceptacja PO”?
2. Czy `/firma` zostaje w fali P0 obok strony głównej? Tak ustawia ten projekt, bo 6.02.2026 firmy są przed klientami. Można zsunąć E05-01 do fali 3.
3. Czy rekomendacje E17-01 i E17-02 (bez URL „24h” i bez osobnej strony usług) są zgodne z tym, czego oczekujesz od copywritera?
4. Czy paczka województwa zamiast 2177 issues gmin jest akceptowalna? Alternatywa zapcha kolejkę i nie zmieści pełnych tekstów w issue.
5. Czy 302 miasta zostają jednym audytem szablonu?
6. Które z 15 propozycji nowych artykułów (E14–E16) w ogóle ruszać? Plan agencji jest z grudnia 2025 i część TODO już żyje jako MDX.
7. Czy kategoria „Technologie i innowacje” ma zostać pusta?
8. Zajawka Facebooka: komentarz w issue (tak jest w tym projekcie) czy osobna kolejka bota?
9. Kim jest rola On-page: człowiek czy bot?
10. Kto pilnuje cytatów prawnych w artykułach z `flaga: prawne`: copywriter zbiera cytat, prawnik go sprawdza, czy oba?
11. Po otwarciu zamówień: jedna zbiorcza zmiana CTA w zaakceptowanych issue, czy od razu trzymamy w issue dwa warianty tekstu?
12. H1 cennika bierzemy z kodu, nie ze zdania „Jedna cena.” w bazie wiedzy. Potwierdź, że baza ma być poprawiona osobno, nie w tym zadaniu.
