# list is currently hosted at:
# https://www.cff.org/PDF-Archive/Study-VX-445-102-Eligible-Mutations-April-2018.pdf
# Because this list is only available as a pdf currently this script is
# basically just manual data entry.
#
# The purpose of this list was to identify "minimal function" mutations (assuming
# the other allele is F508del), which determined eligibility
# in the Middleton (2019) clinical trial of ETI therapy.

library(tibble)

nonsense_vec <- c(
    # column 1:
    "Q2X", "S4X", "W19X", "G27X", "Q39X", "W57X", "E60X", "R75X", "L88X",
    "E92X", "Q98X", "Y122X", "E193X", "W216X",

    # column 2:
    "L218X", "Q220X", "Y275X", "C276X", "Q290X", "G330X", "W401X", "Q414X",
    "S434X", "S466X", "S489X", "Q493X", "W496X", "C524X",

    # column 3:
    "Q525X", "G542X", "G550X", "Q552X", "R553X", "E585X", "G673X", "Q685X",
    "R709X", "K710X", "Q715X", "L732X", "R764X", "R785X",

    # column 4:
    "R792X", "E822X", "W882X", "W846X", "Y849X", "R851X", "Q890X", "S912X",
    "Y913X", "Q1042X", "W1089X", "Y1092X", "W1098X", "R1102X",

    # column 5:
    "E1104X", "W1145X", "R1158X", "R1162X", "S1196X", "W1204X", "L1254X",
    "S1255X", "W1282X", "Q1313X", "Q1330X", "E1371X", "Q1382X", "Q1411X"
)
nonsense_df <- tibble::tibble(variant = nonsense_vec,
                              category = "Nonsense mutations",
                              cat_abbr = "nonsense")

canonical_splice_vec <- c(
    # column 1:
    "185+1G->T", "296+1G->A", "296+1G->T", "405+1G->A", "405+3A->C",
    "406-1G->A", "621+1G->T", "711+1G->T",

    # column 2:
    "711+5G->A", "712-1G->T", "1248+1G->A", "1249-1G->A", "1341+1G->A",
    "1525-2A->G", "1525-1G->A",

    # column 3:
    "1717-8G->A", "1717-1G->A", "1811+1G->C", "1811+1.6kbA->G", "1811+1643G->T",
    "1812-1G->A", "1898+1G->A", "1898+1G->C",

    # column 4:
    "2622+1G->A", "2790-1G->C", "G970R", # G970R instead of 3040G->C, CFTR2-name.
    "3120G->A", "3120+1G->A", "3121-2A->G",

    # column 5:
    "3121-1G->A", "3500-2A->G", "3600+2insT", "3850-1G->A", "4005+1G->A",
    "4374+1G->T"
)
canonical_splice_df <- tibble::tibble(variant = canonical_splice_vec,
                                      category = "Canonical splice mutations",
                                      cat_abbr = "splice")



small_ins_del_vec <- c(
    # column 1:
    "182delT", "306insA", "306delTAGA", "365-366insT", "394delTT", "442delA",
    "444delA", "457TAT->G", "541delC", "574delA", "663delT", "849delG",
    "935delA",

    # column 2:
    "1078delT", "1119delA", "1138insG", "1154insTC", "1161delC", "1213delT",
    "1259insA", "1288insTA", "1343delG", "1471delA", "1497delGG", "1548delG",
    "1609delCA",

    # column 3:
    "1677delTA", "1782delA", "1824delA", "1833delT", "2043delG", "2143delT",
    "2183AA->G", "2184delA", "2184insA", "2307insA", "2347delG", "2585delT",
    "2594delGT",

    # column 4:
    "2711delT", "2732insA", "2869insG", "2896insAG", "2942insT", "2957delT",
    "3007delG", "3028delA", "3171delC", "3171insC", "3271delGG", "3349insT",
    "3659delC",

    # column 5:
    "3737delA", "3791delC", "3821delT", "3876delA", "3878delG", "3905insT",
    "4016insT", "4021dupT", "4022insT", "4040delA", "4279insA", "4326delTC"
)
small_ins_del_df <- tibble::tibble(
    variant = small_ins_del_vec,
    category = paste0("Small (<=3 nucleotide insertion/deletion(ins/del) ",
                      "frameshift mutations"),
    cat_abbr = "small_frameshift"
)



nonsmall_ins_del_vec <- c(
    # column 1:
    "CFTRdele1", "CFTRdele2", "CFTRdele2,3", "CFTRdele2-4", "CFTRdele3-10,14b-16",
    "CFTRdele4-7", "CFTRdele4-11", "CFTR50kbdel", "CFTRdup6b-10", "CFTRdele11",
    "CFTRdele13,14a", "CFTRdele14b-17b",

    # column 2:
    "CFTRdele16-17b", "CFTRdele17a,17b", "CFTRdele17a-18", "CFTRdele19",
    "CFTRdele19-21", "CFTRdele21", "CFTRdele22-24", "CFTRdele22,23",
    "124del23bp", "602del14", "852del22", "991del5",

    # column 3:
    "1461ins4", "1924del7", "2055del9->A", "2105-2177del13insAGAAA", "2372del8",
    "2721del11", "2991del32", "3121-977_3499+248del2515", "3667ins4",
    "4010del4", "4209TGTT->AA"
)
nonsmall_ins_del_df <- tibble::tibble(
    variant = nonsmall_ins_del_vec,
    category = paste0("Non-small (>3 nucleotide insertion/deletion(ins/del) ",
                      "frameshift mutations"),
    cat_abbr = "nonsmall_frameshift"
)


missense_vec <- c(
    # column 1:
    "A46D", "G85E", "R347P", "L467P", "I507del",

    # column 2:
    "V520F", "A559T", "R560T", "R560S", "A561E",

    # column 3:
    "Y569D", "L1056P", "R1066C", "L1077P", "M1101K",

    # column 4:
    "N1303K"
)



missense_df <- tibble::tibble(
    variant = missense_vec,
    category = paste0("Missense mutations that (1) Are not response in vitro ",
                      "to TEZ, IVA or TEZ/IVA and (2) % Panc. Insuff. >50% ",
                      "and SwCl- >86mmol/L"),
    cat_abbr = "missense"
)

vx_445_102 <- rbind(
    nonsense_df,
    canonical_splice_df,
    small_ins_del_df,
    nonsmall_ins_del_df,
    missense_df
)

# The manual checking done after data entry included:
# - printing the dataframe and comparing it to the original list.
# - counting the variants in the dataframe to check that we didn't skip
#   any in the original list.

usethis::use_data(vx_445_102, overwrite = T)
