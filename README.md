# TROLL TEE
Sylvain Schmitt
Apr 2, 2025

[![](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![lint](https://github.com/troll_tee/troll_tee/workflows/lint/badge.svg)](https://github.com/troll_tee/troll_tee/actions?query=workflow%3Alint)

The general idea is to test the ability of TROLL 4.0 (Maréchaux et al.
2024; Schmitt et al. 2024) to simulate a Throughfall Exclusion
Experiment (TEE) in Amazonia based on the Tapajos experiment (Nepstad et
al. 2002) compared to previous model intercomparisons (Powell et al.
2013) to assess its ability to model the response of tropical moist
forests (TMF) to climate change (Joetzjer et al. 2014). Note: Water
stress may be underrepresented due to the potential for pre-dawn
drought, and this may be an opportunity to improve its representation
with explicit tree hydraulic resistance.

## Usage

**troll_tee** analyses rely on the quarto documents (`files.qmd`) that
can be run with R and associated environment defined with [renv](#0).

## Project

**troll_tee** includes:

- Analyse of the data with associated documentation and figures:
  - Reproductive analyses in `files.qmd`
  - Resulting pages in `docs/`
  - Document structure definition in `_quarto.yml`
- All data in `data/`
- Intermediary files in `outputs/`
- Figures in `figures/`
- R environment definition with
  [renv](https://rstudio.github.io/renv/articles/renv.html) in `renv/`
  and `renv/lock`
- R files (`.Rbuildignore` , `.Rdata` , `.Rprofile` , `.Rhistory`)
- Git and GitHub files (`.gitignore` , `.github/`)
- Project documentation (`README.qmd` , `README.md` , `NEWS.md` ,
  `LICENSE`)

## Poeple

- Sylvain Schmitt (sylvain.schmitt@cirad.fr)
- Jérôme Chave (jerome.chave@univ-tlse3.fr)
- Isabelle Maréchaux (isabelle.marechaux@inrae.fr)

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-joetzjer2014" class="csl-entry">

Joetzjer, E., C. Delire, H. Douville, P. Ciais, B. Decharme, R. Fisher,
B. Christoffersen, et al. 2014. “Predicting the Response of the Amazon
Rainforest to Persistent Drought Conditions Under Current and Future
Climates: A Major Challenge for Global Land Surface Models.”
*Geoscientific Model Development* 7 (6): 2933–50.
<https://doi.org/10.5194/gmd-7-2933-2014>.

</div>

<div id="ref-maréchaux2024" class="csl-entry">

Maréchaux, Isabelle, Fabian Jörg Fischer, Sylvain Schmitt, and Jérôme
Chave. 2024. “TROLL 4.0: Representing Water and Carbon Fluxes, Leaf
Phenology and Intraspecific Trait Variation in a Mixed-Species
Individual-Based Forest Dynamics Model Part 1: Model Description.”
<http://dx.doi.org/10.5194/egusphere-2024-3104>.

</div>

<div id="ref-nepstad2002" class="csl-entry">

Nepstad, D. C., P. Moutinho, M. B. Dias-Filho, E. Davidson, G. Cardinot,
D. Markewitz, R. Figueiredo, et al. 2002. “The Effects of Partial
Throughfall Exclusion on Canopy Processes, Aboveground Production, and
Biogeochemistry of an Amazon Forest.” *Journal of Geophysical Research:
Atmospheres* 107 (D20). <https://doi.org/10.1029/2001jd000360>.

</div>

<div id="ref-powell2013" class="csl-entry">

Powell, Thomas L., David R. Galbraith, Bradley O. Christoffersen, Anna
Harper, Hewlley M. A. Imbuzeiro, Lucy Rowland, Samuel Almeida, et al.
2013. “Confronting Model Predictions of Carbon Fluxes with Measurements
of Amazon Forests Subjected to Experimental Drought.” *New Phytologist*
200 (2): 350–65. <https://doi.org/10.1111/nph.12390>.

</div>

<div id="ref-schmitt2024" class="csl-entry">

Schmitt, Sylvain, Fabian Fischer, James Ball, Nicolas Barbier, Marion
Boisseaux, Damien Bonal, Benoit Burban, et al. 2024. “TROLL 4.0:
Representing Water and Carbon Fluxes, Leaf Phenology, and Intraspecific
Trait Variation in a Mixed-Species Individual-Based Forest Dynamics
Model Part 2: Model Evaluation for Two Amazonian Sites.”
<http://dx.doi.org/10.5194/egusphere-2024-3106>.

</div>

</div>
