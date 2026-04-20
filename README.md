
# SemaCombination:

This repo contains the code used to generate statistics for the Sema Combination
study led by [Zach Gerhart-Hines](https://cbmr.ku.dk/research/research-groups/gerhart-hines-group/)
at the Novo Nordisk Foundation Center for Basic Metabolic Research,an independent
research center at the University of Copenhagen, partially funded by an 
unrestricted donation from the Novo Nordisk Foundation (GFrant ID NNF23SA0084103)

The analysis explores how energy expenditure (obtained from indirect 
calorimetry) and food intake are affected by various treatments. The quarto file
found in the Docs folder explains more details about the setup and analysis 
rationale.

The repo will be updated with a link to the study once data has been published.


# Brief description of folder and file contents


The following folders contain:

-   `data-raw/`: contains all raw data used for the study (empty here, available upon request)
-   `docs/`: contains a quarto document describing the analysis and how to obtain the results
-   `R/`: contains a script with custom support functions

# Installing project R package dependencies

Used packages are available in the "DESCRIPTION" file. The project uses the renv 
package, so packages can be installed with `renv::install()`.

To re-run script with data (which can be provided through reasonable request through
[Morten Dall](mailto:dall@sund.ku.dk)) data files must be placed in a folder in 
`data-raw/` called `sema`.
