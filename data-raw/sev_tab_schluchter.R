# Data comes from Schluchter (2006) "Classifying severity..."
# DOI: 10.1164/rccm.200512-1919OC

library(magrittr)
library(dplyr)

sev_tab_schluchter <- tibble::tribble(
    ~age_lb, ~severe, ~mild,
    8, 80, NA,
    9, 79, NA,
    10, 78, NA,
    11, 77, NA,
    12, 75, NA,
    13, 72, NA,
    14, 69, NA,
    15, 67, 97,
    16, 63, 92,
    17, 60, 90,
    18, 59, 87,
    19, 57, 86,
    20, 54, 84,
    21, 50, 82,
    22, 45, 77,
    23, 39, 70,
    24, 36, 68,
    25, 34, 67,
    26, NA, 62,
    27, NA, 58,
    28, NA, 54,
    29, NA, 52,
    30, NA, 50,
    31, NA, 45,
    32, NA, 32,
    33, NA, 32,
    34, NA, 0
)

# version with derived data for merging:
sev_tab_merge_schluchter <- sev_tab_schluchter %>%
    dplyr::mutate(severe = if_else(age_lb > 25, 0, severe),
                  mild = if_else(age_lb < 15, 97, mild)) %>%
    dplyr::mutate(age_ub = dplyr::lead(age_lb, default = 35),
                  s0 = severe,
                  s1 = dplyr::lead(severe),
                  m0 = mild,
                  m1 = dplyr::lead(mild, default = 0))



usethis::use_data(sev_tab_schluchter, overwrite = T)
usethis::use_data(sev_tab_merge_schluchter, overwrite = T, internal = T)
