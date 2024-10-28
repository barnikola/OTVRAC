# Baza podataka esports timova README

Ovaj skup podataka sadrži informacije o esports timovima i njihovim igračima

## Licenca

## Autor

Nikola Baretić

## Verzija podataka

1.0

## Jezik podataka

Hrvatski

## Opis podataka

Tablica tim

- 'naziv': Naziv tima
- 'skracenica': Skracenica tima
- 'godinaOsnutka': Godina osnutka tima
- 'esport': Esport u kojem se natječu
- 'brojTrofeja': Broj osvojenih trofeja
- 'drzava': Država iz koje tim dolazi
- 'pobjede2023': Broj pobjeda u sezoni 2023
- 'porazi2023': Broj poraza u godini 2023
- 'igraci2023': Broj igrača u godini 2023
- 'regija': Regija u kojoj se tim natječe
- 'ukupnaZarada': Ukupna zarada tima u USD

Tablica igraci

- 'igrac_id': Jedinstveni ID za svakog igrača
- 'puno_ime': Puno ime igrača
- 'nickname': Igrački nadimak (nickname) igrača
- 'pozicija': Pozicija igrača u timu (npr. Jungle, ADC)
- 'godina_prikljucenja': Godina kada se igrač pridružio timu
- 'tim_id': Veza prema timu kojem igrač pripada

##

# Baza podataka o Esport Timovima i Igračima

Ovaj skup podataka sadrži informacije o raznim esport timovima i njihovim igračima, uključujući podatke o njihovim uspjesima iz različitih igara (League of Legends, Valorant, CS:GO, Rocket League). Podaci su strukturirani u dvije tablice: **tim** i **igraci**.

- **Licenca**: [Creative Commons Zero v1.0 Universal (CC0 1.0)](https://creativecommons.org/publicdomain/zero/1.0/)

- **Autor**: Nikola Baretić
- **Kontak**: nikola.baretic@gmail.com
- **Verzija skupa podataka**: 1.0
- **Jezik podataka**: Hrvatski
- **Opis atributa u tablici `tim`**:

  - `tim_id`: Jedinstveni ID za svaki tim (SERIAL).
  - `naziv`: Naziv tima (VARCHAR).
  - `skracenica`: Službena skraćenica tima (VARCHAR).
  - `godina_osnutka`: Godina osnutka tima (INT).
  - `esport`: Esport u kojem se tim natječe (VARCHAR).
  - `broj_trofeja`: Broj osvojenih trofeja (INT).
  - `drzava`: Država iz koje tim dolazi (VARCHAR).
  - `pobjede2023`: Broj pobjeda u sezoni 2023 (INT).
  - `porazi2023`: Broj poraza u sezoni 2023 (INT).
  - `regija`: Regija u kojoj se tim natječe (VARCHAR).
  - `ukupna_zarada`: Ukupna zarada tima u USD (DECIMAL).

- **Opis atributa u tablici `igraci`**:

  - `igrac_id`: Jedinstveni ID za svakog igrača (SERIAL).
  - `puno_ime`: Puno ime igrača (VARCHAR).
  - `nickname`: Igrački nadimak igrača (VARCHAR).
  - `pozicija`: Pozicija igrača u timu (VARCHAR).
  - `godina_prikljucenja`: Godina kada se igrač pridružio timu (INT).
  - `tim_id`: ID tima kojem igrač pripada (INT, strani ključ).

- **Datum posljednjeg ažuriranja**: 27.10.2024.
- **Učestalost ažuriranja**: Godišnja/po potrebi
- **Izvor podataka**: Prikupljeni iz službenih izvora esport liga i relevantnih web stranica.

## Distribucija Skupa Podataka

### CSV Distribucija

- **Naslov:** CSV distribucija skupa podataka o esports timovima i njihovim igračima
- **Opis:** CSV distribucija skupa podataka o esports timovima i njihovim igračima.
- **Medijski tip:** text/csv

### JSON Distribucija

- **Naslov:** JSON distribucija skupa podataka o esports timovima i njihovim igračima.
- **Opis:** JSON distribucija skupa podataka o esports timovima i njihovim igračima.
- **Medijska vrsta:** application/json

## Povijest verzija skupa podataka

| **Verzija** | **Datum izdavanja** | **Promjene**                |
| ----------- | ------------------- | --------------------------- |
| 1.0         | 27.10.2024          | Prva verzija skupa podataka |
