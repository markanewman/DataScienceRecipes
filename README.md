# Data Science Recipes

[![R](https://img.shields.io/badge/R-4.0.x-blue)](https://cran.r-project.org)
[![MIT license](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4665256.svg)](https://doi.org/10.5281/zenodo.4665256)

> 50% of data science is copy + paste.
> The other 50% is figuring out what to copy + paste.

This work is a collection of scripts you can copy + paste into your project.
They should be fully annotated and self explanatory.
If more explanation is needed, submit an [issue](https://github.com/markanewman/DataScienceRecipes/issues) and I will look into it.
If you use the work in something that is public facing, adding a no-cite reference to my DOI is appreciated.

# Recipes

I categorize my Recipes into things that make sense to _me_.
That means you may need to use the GitHub search feature to find something that helps you.
Also, a particular recipe may belong to more than one category.
In that case, it will be listed under both.

## EDA

* [Binary Classification](./recipes/eda-classification.rmd)

## Monte-Carlo Simulations

* [t-test vs Logistic Regression](./recipes/mc-ttvslr.rmd)

# Software

The recipes presented are intended to be used in [R](https://cran.r-project.org/bin/windows/base/) / [R Studio](https://www.rstudio.com/products/rstudio/download/).
You can use any method to install them, but if you are on Windows you may consider using a [Chocolatey](https://chocolatey.org/install) script.

Open an _admin_ PowerShell prompt and run the code snippet below.
  
```{ps1}
if('Unrestricted' -ne (Get-ExecutionPolicy)) { Set-ExecutionPolicy Bypass -Scope Process -Force }
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
refreshenv
choco install r.project -y
choco install r.studio -y
```
