---
title:  |
  | Food-web structure derived from
  | maximum entropy and species richness
author: |
  | Francis Banville
  | Timothée Poisot
  | Dominique Gravel

date: October 2020
fontsize: 12pt
linestretch: 2
geometry: margin=2.54cm
output: pdf_document
---

# Introduction

# Methodology

# Results

We used the principle of maximum entropy to derive degree distributions that best represented our prior knowledge of food webs. A degree distribution is a discrete probability distribution $p_k$ that a species establishes $k$ links in a food web. Following the argument presented above (to be written), $k$ has to vary between $1$ and $S$ links, $S$ being the total number of species in the network. The probability mass outside these boundaries is zero: a species in a food web has at least one interaction and cannot have more interactions than the total number of species in the network.

Our degree distributions each had maximum entropy $H=-\sum_{k=1}^{S} p_k \log p_k$ subject to two constraints:


$$g_1 = \sum_{k=1}^{S} p_k = 1,$${#eq:g1}
$$g_2 = \langle k \rangle = \sum_{k=1}^{S} k p_k = \frac{2L}{S}.$${#eq:g2}


The first constraint $g_1$ normalizes all probabilities so they sum to 1. The second constraint $g_2$ is the mean degree $\langle k \rangle$ of the network, which is the double of its linkage density $L/S$. The flexible links model of MacDonald and colleagues (submitted) provides an expected distribution for the total number of links $L$ in a food web of known species richness $S$. We could sample a value $L_i$ from this distribution to compute a maximum entropy degree distribution with mean $2L_i/S$. Doing so several times would allow us to obtain a distribution of maximum entropy degree distributions, which could potentially act as a null model for network comparison.

Using Lagrange multipliers, we find that the maximum entropy degree distributions are of the form

$$p_k = c r^{k},$${#eq:maxent}

where $c$ and $r$ are positive numbers whose values can be determined from the mean and normalization constraints. For large networks, these parameters approach

$$c \approx \frac{{1}}{\langle k \rangle-1},$$

$$r \approx \frac{{\langle k \rangle-1}}{\langle k \rangle}.$$

We found that this approximation works surprisingly well for networks of $S \geq 5$ species. This has favorable consequences, since we could derive the maximum entropy degree distributions analytically from $L$ and $S$, computationally inexpensively and with negligible discrepancies from our constraints for large networks.

To obtain such distributions, we computed a predictive posterior distribution of $L$ from the flexible links model of MacDonald and colleagues (submitted), for food webs of fixed $S$ values. To do so, we first fitted our model using the same priors and data as these authors (i.e. all food webs archived on the `mangal.io` database). We ran our model in Stan, using four chains and 2000 iterations per chain. We obtained a joint posterior distribution for the parameters $\mu$ and $\phi$. We then generated a predictive posterior distribution of $L$ by simulating 1000 draws from


$$L \sim \mathrm{BB}(S^2 - (S - 1), \mu \phi, (1 - \mu) \phi),$${#eq:BB}

where $\mathrm{BB}$ is a beta-binomial distribution with $S^2 -(S-1)$ trials and parameters $\alpha = \mu \phi$ and $\beta = (1 - \mu) \phi$ (see MacDonald and colleagues for more explanations).

We computed the expected distribution of mean degrees for a food web of known $S$ using its predictive posterior distribution. Specifically, we multiplied each instance in the distribution by the constant $2/S$. As an illustration, @fig:md_150 presents the expected distribution of mean degrees for a food web of 150 species.

A maximum entropy degree distribution can be computed from @eq:maxent and by drawing its mean degree $\langle k \rangle$ from this posterior predictive distribution. @fig:dd_150 depicts 7 such distributions, for a network of 150 species, computed using the 0.015, 0.055, 0.165, 0.500 (median), 0.835, 0.945, and 0.985 quantiles of @fig:md_150. These quantiles were chosen because they delimit the 67%, 89%, and 97% percentile intervals of the distribution of $\langle k \rangle$, along with its median. These intervals are arbitrary, but allow us to capture most of the variation of the predictive posterior distribution, as shown in @fig:md_150.

\pagebreak

![**Posterior predictive distribution of mean degrees for a food web of 150 species.** The median of the distribution (solid pink line) is plotted along with the 67% (delimited by the solid grey lines), 89% (delimited by the dashed lines), and 97% (delimited by the dotted lines) percentile intervals. The grey area represents the 97% percentile interval.](fig/md_150.png){#fig:md_150}

\pagebreak

![**Degree distributions of a food web of 150 species.** Each degree distribution $p_k$ has maximum entropy under the mean degree and normalization constraints. Mean degrees $\langle k \rangle$ were obtained from the posterior predictive distribution (PPD) of the flexible links model. The distribution in pink had a $\langle k \rangle$ of 24.3 (median of the PPD), the solid grey distributions (67% PI of the PPD) had a $\langle k \rangle$ of 12.1 (top) and 43.3 (bottom), the dashed distributions (89% PI of the PPD) had a $\langle k \rangle$ of 7.3 (top) and 58.8 (bottom), and the dotted distributions (97% PI of the PPD) had a $\langle k \rangle$ of 4.6 (top) and 75.1 (bottom). Note that although degree distributions are typically discrete, we plotted them continuous for clarity reasons. Note also the log scale of the x-axis.](fig/dd_150.png){#fig:dd_150}

\pagebreak

We computed the empirical degree distributions of the six largest food webs archived on `mangal.io` (@fig:emp_dd). The largest food web had 714 species and 33,263 links. The other five largest had between 78 and 100 species, with total numbers of links ranging from 114 to 750. We also computed the maximum entropy degree distributions using these numbers of links and species, i.e. having the exact same $\langle k \rangle$ as these large empirical food webs (@fig:emp_dd). Although the maximum entropy distributions underestimate both the probabilities of low and large-degree nodes, they fit the data surprisingly well.

\pagebreak

![**Degree distributions of the six largest food webs archived on `mangal.io`**. The number of species $S$ and of links $L$ are indicated at the top right of each subplot. The maximum entropy degree distributions with mean degree $\langle k \rangle = 2L/S$ are plotted in pink in each subplot.](fig/emp_dd.png){#fig:emp_dd}

# Discussion

# Conclusion

\pagebreak

# References

::: {#refs}
:::

\pagebreak
