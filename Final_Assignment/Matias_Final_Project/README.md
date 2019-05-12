Matías Gómez
------------

Final Assignment for BIO 594
----------------------------

Genetic structure and dispersal of the mountainous star coral along the Caribbean basin
=======================================================================================

Summary
-------

Coral reefs are declining worldwide as a result of local and global
factors including the effects of climate change (Bruno and Valdivia,
2016). This decline is marked in Caribbean reefs where coral cover is
now below 15% in many areas (Jackson et al., 2014) . Conservation
efforts are urgently needed to reduce such loss, recover depleted
populations and restore natural habitats. However, effective management
of coral reefs relies on characterizing genetic diversity and the level
to which spatially discrete populations are linked by dispersal (Rippe
et al., 2017). The mountainous star coral, *Orbicella faveolata*, is a
hermaphroditic massive species, and therefore key in structuring coral
reefs along the Caribbean basin, that exhibits a broadcast spawner
reproductive strategy with a long-distance dispersal potential (Davies
et al., 2013; Levitan et al., 2011). Genetic diversity, structure an
connectivity of this species has been evaluated so far from
microsatellites data only (Rippe et al., 2017). Here, I aim to examine
patterns of genetic structure, connectivity and isolation by distance
for this species among four locations on the Caribbean, taking advantage
of existing wide-genome data and the availability of an assembled
reference genome (Prada et al., 2016).

Data description
----------------

A total of 195 tissue samples from colonies of the mountainous star
coral, *O. faveolata*, were collected from three populations along the
Caribbean basin (table 1). After DNA extraction of each sample,
reduced-genome representation libraries were created by Genotyping by
Sequencing (GBS) using a frequent enzyme cutter, ApeKI, a
four-nucleotide cutter. The assembled genome of Orbicella faveolata (485
Mb) contains 1932 scaffolds with an N50 of 1.16 Mbp and 90% of the
genome falls in 98 scaffolds (Prada et al., 2016).

<table>
<thead>
<tr class="header">
<th>Population</th>
<th>No. Colonies</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Curacao (CU)</td>
<td>95</td>
</tr>
<tr class="even">
<td>Panama (PAN)</td>
<td>16</td>
</tr>
<tr class="odd">
<td>Puerto Rico (PR)</td>
<td>79</td>
</tr>
</tbody>
</table>

Table 1. Location and number of colonies sampled for each population of
*O. faveolata* across the Caribbean.

Analysis plan
-------------

-   Raw sequencing reads were demultiplexed, quality filtered and
    aligned to the *O. faveolata* reference genome using de dDocent
    pipeline (Puritz et al., 2014)
-   SNP calling was carried out with the aforementioned pipeline to
    produce a VCF that was filtered to keep variants that have been
    successfully genotyped in 50% of individuals only, a minimum quality
    score of 30, and a minor allele count of 3.
-   Recode genotypes that have less than 3 reads, removed individuals
    with more than 75% missing data, filtered out loci with an allele
    balance below 0.25 and above 0.75, a minimum read depth of 10x,
    deviations from Hardy–Weinberg equilibrium in each population, and
    an overall minor allele frequency (MAF) of 5%.
-   This final VCF was scanned for putative loci under natural selection
    using BayeScan v.2.1 (unsuccessfully) and pcadapt v.4.0.2 (partially
    successfully)
-   Loci identified by any of these methods were removed in order to
    continue with an exclusively neutral set of loci to examine genetic
    structure.
-   Analysis of principal components (PCA) and discriminant analysis of
    principal components (DAPC) using the adegenet package.These two
    model-free methods do not make any underlying biological assumptions
    to find genetic clusters.
-   Additionally, genetic structure was explored through the estimation
    of the pairwise Fst with the package hierfstat and a Mantel test was
    applied to look for evidence of isolation-by-distance as an indirect
    measure of potential connectivity.

References
----------

Bruno, J. F., and Valdivia, A. (2016). Coral reef degradation is not
correlated with local human population density. Sci. Rep. 6.
<doi:10.1038/srep29778>.

Davies, S. W., Rahman, M., Meyer, E., Green, E. A., Buschiazzo, E.,
Medina, M., et al. (2013). Novel polymorphic microsatellite markers for
population genetics of the endangered Caribbean star coral, Montastraea
faveolata. Mar. Biodivers. 43, 167–172. <doi:10.1007/s12526-012-0133-4>.

Jackson, J. B. C., Donovan, M. K., Cramer, K. L., and Lam, V. V. (2014).
Status and Trends of Caribbean Coral Reefs.

Levitan, D. R., Fogarty, N. D., Jara, J., Lotterhos, K. E., and
Knowlton, N. (2011). Genetic, Spatial, and Temporal Components of
Precise Spawning Synchrony in Reef Building Corals of the Montastraea
Annularis Species Complex. Evolution 65, 1254–1270.
<doi:10.1111/j.1558-5646.2011.01235.x>.

Prada, C., Hanna, B., Budd, A. F., Woodley, C. M., Schmutz, J.,
Grimwood, J., et al. (2016). Empty Niches after Extinctions Increase
Population Sizes of Modern Corals. Curr. Biol. 26, 3190–3194.
<doi:10.1016/j.cub.2016.09.039>.

Puritz, J. B., Hollenbeck, C. M., and Gold, J. R. (2014). dDocent : a
RADseq, variant-calling pipeline designed for population genomics of
non-model organisms. PeerJ 2, e431. <doi:10.7717/peerj.431>.

Rippe, J. P., Matz, M. V., Green, E. A., Medina, M., Khawaja, N. Z.,
Pongwarin, T., et al. (2017). Population structure and connectivity of
the mountainous star coral, Orbicella faveolata , throughout the wider
Caribbean region. Ecol. Evol. <doi:10.1002/ece3.3448>.
