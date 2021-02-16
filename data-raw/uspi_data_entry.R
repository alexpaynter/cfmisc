# This data comes from table 4 in the Dec 20, 2020 USPI for Trikafta.
# The current link for this is:
# https://www.accessdata.fda.gov/drugsatfda_docs/label/2020/212273s002lbl.pdf
# And more generally it can be found by searching "trikafta" on the
# Access FDA search bar.

# The purpose of this list is to state mutations which ARE responsive
# to Trikafta.  Because it's only available in PDF form this script is
# literally just a bunch of strings.

uspi_2020dec20_invitro <- c(
    # column 1:
    "3141del9", "546insCTA", "A46D", "A120T", "A234D", "A349V", "A455E",
    "A554E", "A1006E", "A1067T", "D110E", "D110H", "D192G", "D443Y",
    "D443Y;G576A;R668C", "D579G", "D614G", "D836Y", "D924N", "D979V", "D1152H",
    "D1270N", "E56K", "E60K", "E92K", "E116K", "E193K", "E403D", "E474K",
    "E588V",

    # column 2:
    "E822K", "F191V", "F311del", "F311L", "F508C", "F508C;S1251N", "F508del",
    "F575Y", "F1016S", "F1052V", "F1074L", "F1099L", "G27R", "G85E", "G126D",
    "G178E", "G178R", "G194R", "G194V", "G314E", "G463V", "G480C", "G551D",
    "G551S", "G576A", "G576A;R668C", "G622D", "G628R", "G970D", "G1061R",

    # column 3:
    "G1069R", "G1244E", "G1249R", "G1349D", "H139R", "H199Y", "H939R", "H1054D",
    "H1085P", "H1085R", "H1375P", "I148T", "I175V", "I336K", "I502T", "I601F",
    "I618T", "I807M", "I980K", "I1027T", "I1139V", "I1269N", "I1366N", "K1060T",
    "L15P", "L165S", "L206W", "L320V", "L346P", "L453S",

    # column 4:
    "L967S", "L997F", "L1077P", "L1324P", "L1335P", "L1480P", "M152V", "M265R",
    "M952I", "M952T", "M1101K", "P5L", "P67L", "P205S", "P574H", "Q98R",
    "Q237E", "Q237H", "Q359R", "Q1291R", "R31L", "R74Q", "R74W", "R74W;D1270N",
    "R74W;V201M", "R74W;V201M;D1270N", "R75Q", "R117C", "R117G", "R117H",

    # column 5:
    "R117L", "R117P", "R170H", "R258G", "R334L", "R334Q", "R347H", "R347L",
    "R347P", "R352Q", "R352W", "R553Q", "R668C", "R751L", "R792G", "R933G",
    "R1066H", "R1070Q", "R1070W", "R1162L", "R1283M", "R1283S", "S13F", "S341P",
    "S364P", "S492F", "S549N", "S549R", "S589N", "S737F",

    # column 6:
    "S912L", "S945L", "S977F", "S1159F", "S1159P", "S1251N", "S1255P", "T338I",
    "T1036N", "T1053I", "V201M", "V232D", "V456A", "V456F", "V562I", "V754M",
    "V1153E", "V1240G", "V1293G", "W361R", "W1098C", "W1282R", "Y109N", "Y161D",
    "Y161S", "Y563N", "Y1014C", "Y1032C"
)


# Checks on the data entry above:
# - Check that there are 30*6-2 = 178 total (as in Table 4)
# - print out the list (as a tibble) and double check it with Table 4.

usethis::use_data(uspi_2020dec20_invitro, overwrite = T)
