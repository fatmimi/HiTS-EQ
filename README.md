HiTS-EQ
-------

This is the document for calculation of more than 4000 association
constants from HiTS-EQ Next generation sequencing dataset.

1.  Input your data. The data format is in .csv file and the csv file
    format is shown below.

<!-- -->

    #Data input
    test.import <- read.csv('import_data.csv', header=T)
    head(test.import)

    ##      Seq   X1      X2     X3      X4
    ## 1      f    0    0.25    0.5    0.75
    ## 2    [E]    0    6.67   20.0   60.00
    ## 3 AAAAAA 4133 1425.00 1754.0 1422.00
    ## 4 AAAAAC 2662 1049.00  998.0  953.00
    ## 5 AAAAAG 5247 2726.00 2612.0 2322.00
    ## 6 AAAAAT 3352 1115.00 1073.0  842.00

Here f means fraction of reaction and the 100% binding is 1. 0.5 means
50% E-S complex formation or \[ES\]/\[S\]) = 0.5.

Result output
-------------

After fitting, the association constant (KA), dissociation constant (K),
and relative association constant (RKA) will be exported in the
following format.

    head(finalresult)

    ##   sequence         K         KA      RKA
    ## 3   AAAAAA  7.968890 0.12548800 1.885934
    ## 4   AAAAAC  8.600381 0.11627392 1.747457
    ## 5   AAAAAG 15.028800 0.06653891 1.000000
    ## 6   AAAAAT  6.204218 0.16118068 2.422352
    ## 7   AAAACA  4.823659 0.20731150 3.115643
    ## 8   AAAACC  5.540732 0.18048156 2.712421

To export your file, please change the export filename in HiTS-EQ\_v2.R
script.

    write.csv(finalresult,"output.csv")

Show the RKA distribution by histogram
--------------------------------------

To observe the distribution of relative association constants, we used
RKA and log(RKA). log(RKA) has more physical meanings in binding energy.

![](README_files/figure-markdown_strict/unnamed-chunk-5-1.png)

![](README_files/figure-markdown_strict/unnamed-chunk-6-1.png)
