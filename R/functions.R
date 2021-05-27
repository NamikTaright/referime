
#' ~ api : recuperer une table (referentiel)
#'
#'
#' @examples
#' \dontrun{
#' get_table('dictionnaire_tables')
#' get_table('ccam_actes')
#' get_table('cim', time_interval = 2018)
#' get_table('ghm_ghm_regroupement', time_interval = 2017:2018)
#' }
#'
#' @author G. Pressiat
#' @import magrittr curl  dplyr 
#' @importFrom jsonlite fromJSON
#' @importFrom purrr map_df
#' @export
get_table <- function(table, time_interval = '',
                      def_url = 'http://referime.aphp.fr/v0.2/'){
  library(magrittr)
  vv <- function(one){
    if (one == ''){
      path <- def_url %>%
        paste0('ref/', table, '/json')
      u <- path %>%
        curl::curl() %>%
        jsonlite::fromJSON() %>%
        dplyr::select(-dplyr::starts_with('time_i'))
      message('## Retrieving data from ', path)
      
    }else if (one != ''){
      path <- def_url %>%
        paste0('ref/', table, '/json?time_interval=', one) 
      u <- path %>%
        curl::curl() %>%
        jsonlite::fromJSON() %>%
        dplyr::select(-dplyr::starts_with('time_i'))
      message('## Retrieving data from ', path)
    }
    u %>% dplyr::as_tibble()
  }
  time_interval %>% purrr::map_df(vv)
  
}


#' ~ api : recuperer les finess etablissement Etalab
#'
#'
#' @examples
#' \dontrun{
#' get_finess_et()
#' get_finess_et(departement = '75')
#' get_finess_et(departement = c('36', '15'))
#' }
#' @author G. Pressiat
#' @import magrittr curl dplyr
#' @export
get_finess_et <- function(departement = c('75', '77', '78', '91', '92', '93', '94', '95'),
                          def_url = 'http://referime.aphp.fr/v0.1/'){
  requireNamespace(magrittr)
  v <- function(one){
    path <- def_url %>%
      paste0('ref/finess_et/', one)
    
    u <- path %>%
      curl::curl() %>%
      jsonlite::fromJSON()
    message('## Retrieving data from ', path)
    u %>% dplyr::as_tibble()

  }
  departement %>% purrr::map_df(v)
  
}

#' ~ api : recuperer les finess juridique Etalab
#'
#' @examples
#' \dontrun{
#' get_finess_ej()
#' get_finess_ej(departement = '75')
#' get_finess_ej(departement = c('54', '32'))
#' }
#' @author G. Pressiat
#' @import magrittr curl dplyr 
#' @export
get_finess_ej <- function(departement = c('75', '77', '78', '91', '92', '93', '94', '95'),  def_url = 'http://referime.aphp.fr/v0.1/'){
  requireNamespace(magrittr)
  v <- function(one){
    path <- def_url %>%
      paste0('ref/finess_ej/', one)
    
    u <- path %>%
      curl::curl() %>%
      jsonlite::fromJSON()
    message('## Retrieving data from ', path)
    u %>% dplyr::as_tibble()

  }
  departement %>% purrr::map_df(v)
  
}

#' ~ api : recuperer une liste
#'
#'
#' @examples
#' \dontrun{
#' get_liste('chir_bariatrique_total')
#' }
#'
#' @author G. Pressiat
#' @import magrittr jsonlite curl
#' @export
get_liste <- function(nom_liste, def_url = 'http://referime.aphp.fr/v0.2/'){
  path <- def_url %>%
    paste0('listes/', nom_liste)
  message('## Retrieving data from ', path)
  def_url %>%
    paste0('listes/', nom_liste) %>%
    curl::curl() %>%
    jsonlite::fromJSON(simplifyVector = T)

}

#' ~ api : recuperer toutes les listes sur une thematique
#'
#'
#' @examples
#' \dontrun{
#' get_all_listes("Chirurgie bariatrique")
#' }
#'
#' @author G. Pressiat
#' @import magrittr jsonlite curl
#' @importFrom dplyr filter
#' @export
get_all_listes <- function(theme, def_url = 'http://referime.aphp.fr/v0.2/'){
  get_dictionnaire() %>%
    filter(thematique == theme) %>% .$nom_abrege -> l
  message('## ## ', length(l), ' lists retrieved from ', def_url, ' with thematic : ', theme)
  lapply(l, get_liste)
}

#' ~ api : recuperer le dictionnaire des listes
#'
#'
#' @examples
#' \dontrun{
#' get_dictionnaire()
#' }
#'
#' @author G. Pressiat
#' @export
get_dictionnaire <- function(def_url = 'http://referime.aphp.fr/v0.2/'){
  path <- def_url %>%
    paste0('listes/dictionnaire')
  message('## Retrieving data from ', path)
  path %>% 
    curl::curl() %>%
    jsonlite::fromJSON() %>%
    dplyr::as_tibble()

}

#' ~ req : transformer une liste en df
#'
#'
#' @examples
#' \dontrun{
#' get_liste('chir_bariatrique_total') -> l
#' tidy_liste(l, "actes")
#'
#' get_all_listes("Chirurgie bariatrique") -> ll
#' lapply(ll, function(x)tidy_liste(x, "actes")) %>% bind_rows() -> actes_chir_bar
#' }
#'
#' @author G. Pressiat
#' @importFrom purrr map_chr map flatten_chr
#' @importFrom dplyr data_frame
#' @export
tidy_liste <-  function(ma_liste, element){
  as.data.frame(ma_liste[c('thematique', 'nom', element)], stringsAsFactors = F) %>% tbl_df()
}

