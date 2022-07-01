# Chromosome-Grid-Plot

The main purpose for creating chromosome grid plot is to undersatnding the most affected chromosome that has alternative splicing events happened.

Here, I create the R function for plotting the chromosome grid plot. There are grid plots for Human and Mouse in different functions. Moreover, there are also two ways to create the plot, one is just the frequency of the events, the other is the frequency that normalized by the number of bands in each chromosome, which can show the density and that is correspond to the existing R package [Karyoplote](https://github.com/bernatgel/karyoploteR)

## Data Preparation

In order to plot the chromosome grid plot, we need files that have chromosome and band annotation.

