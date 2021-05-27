# package pour interfacer avec l'api referime en R


[http://referime.aphp.fr](http://referime.aphp.fr)


```r
devtools::install_git('http://164.1.196.52:8086/4073189/referime.git')
```

# référentiels

## cas général

Toutes les tables peuvent être récupérées avec la fonction `get_table`.

```r
cim <- referime::get_table(table = 'cim', time_interval = '2019')
## Retrieving data from http://referime.aphp.fr/v0.2/ref/cim/json?time_interval=2019
```

```r
ccam <- referime::get_table(table = 'ccam_actes')
## Retrieving data from http://referime.aphp.fr/v0.2/ref/ccam_actes/json
```

```r
dictionnaire_tables <- referime::get_table(table = 'dictionnaire_tables')
## Retrieving data from http://referime.aphp.fr/v0.2/ref/dictionnaire_tables/json
```


## cas particulier : finess

Si la fonction `get_table` permet de récupérer l'intégralité des tables finess (finess_et : établissement géo, et finess_ej : entités juridiques) pour toute la France, données issus de data.gouv.fr, il peut être plus efficace de ne télécharger ces informations que pour quelques départements:

**avec `get_table`**

```r
finess_ej <- referime::get_table(table = 'finess_ej')
## Retrieving data from http://referime.aphp.fr/v0.2/ref/finess_ej/json
```

Deux fonctions pour les deux tables et et ej, par défaut l'IDF est récupérée :

```r
finess_ej <- referime::get_finess_ej()
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/75
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/77
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/78
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/91
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/92
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/93
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/94
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_ej/95
```

```r
finess_mini <- referime::get_finess_et(departement = c('36', '15'))
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_et/36
## Retrieving data from http://referime.aphp.fr/v0.1/ref/finess_et/15
```


# listes de requêtes

```r
referime::get_liste('chip')
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chip

referime::get_dictionnaire()
## Retrieving data from http://referime.aphp.fr/v0.2/listes/dictionnaire

referime::get_all_listes('Chirurgie bariatrique')
## Retrieving data from http://referime.aphp.fr/v0.2/listes/dictionnaire
## ## 8 lists retrieved from http://referime.aphp.fr/v0.2/ with thematic : Chirurgie bariatrique
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_anneau
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_bi
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_bypass
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_ccb
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_gvc
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_sleeve
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_sonde
## Retrieving data from http://referime.aphp.fr/v0.2/listes/chir_bariatrique_total
```

