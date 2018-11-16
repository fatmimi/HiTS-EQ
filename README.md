HiTS-EQ
================
Hsuan-Chun Lin
November 2, 2018

HiTS-EQ
=======

This is the document for calculation of more than 4000 association constants from HiTS-EQ Next generation sequencing dataset. It would be great if you could cite our publication after your application of HiTS-EQ:

**Analysis of the RNA binding specificity landscape of C5 protein reveals structure and sequence preferences that direct RNase P specificity**
HC Lin, J Zhao, CN Niland, B Tran, E Jankowsky, ME Harris
Cell chemical biology 23 (10), 1271-128

<https://www.sciencedirect.com/science/article/pii/S2451945616302975>

Equation Derivation
-------------------

The internal competition equation which is used in this .R file to process the nonlinear regression is shown below:
$$f = 1 -( \\frac{D\_{t}}{D\_t1}\\times (1-frac) \\times \\frac{D\_1}{D\_0})= \\frac{E}{E+K\_D}$$
For more detail of this equation, please see the pdf file &lt;EQ-directFit.pdf&gt; in ./Equation/

File list
---------

HiTS-EQ\_v2.R : The R script to do the calculation.
import\_data.csv : The .csv file to demo the calculation and show the format of the input file.
output.csv: The .csv file which has your results includes K, KA and RKA.

Import your data
----------------

The data format is in .csv file and the csv file format is shown below.

``` r
#Data input
test.import <- read.csv('import_data.csv', header=T)
head(test.import)
```

    ##      Seq   X1      X2     X3      X4
    ## 1      f    0    0.25    0.5    0.75
    ## 2    [E]    0    6.67   20.0   60.00
    ## 3 AAAAAA 4133 1425.00 1754.0 1422.00
    ## 4 AAAAAC 2662 1049.00  998.0  953.00
    ## 5 AAAAAG 5247 2726.00 2612.0 2322.00
    ## 6 AAAAAT 3352 1115.00 1073.0  842.00

Here f means fraction of reaction and the 100% binding is 1. 0.5 means 50% E-S complex formation or \[ES\]/\[S\]) = 0.5.

Fitting parameter adjustment
----------------------------

Here we only need one initial value for the non linear fitting, the K. you can set it in the .R file in the fitting part:

``` r
#fitting
test$K <- 0
start.values = list(K = 0.01)
```

Choose the reference sequence to calculate the relative association constants.
------------------------------------------------------------------------------

TBA

Result output
-------------

After fitting, the association constant (KA), dissociation constant (K), and relative association constant (RKA) will be exported in the following format.

``` r
head(finalresult)
```

    ##   sequence         K         KA      RKA
    ## 3   AAAAAA  7.968877 0.12548819 1.885937
    ## 4   AAAAAC  8.600387 0.11627384 1.747456
    ## 5   AAAAAG 15.028799 0.06653892 1.000000
    ## 6   AAAAAT  6.204215 0.16118075 2.422353
    ## 7   AAAACA  4.823660 0.20731145 3.115642
    ## 8   AAAACC  5.540732 0.18048158 2.712421

To export your file, please change the export filename in HiTS-EQ\_v2.R script.

``` r
write.csv(finalresult,"output.csv")
```

Show the RKA distribution by histogram
--------------------------------------

To observe the distribution of relative association constants, we used RKA and log(RKA). log(RKA) has more physical meanings in binding energy.

``` r
hist(finalresult$RKA)
```

![](README_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
hist(log(finalresult$RKA))
```

![](README_files/figure-markdown_github/unnamed-chunk-8-1.png)
