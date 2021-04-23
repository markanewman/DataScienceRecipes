# Data Science Recipes

[![R](https://img.shields.io/badge/R-4.0.x-blue)](https://cran.r-project.org)
[![MIT license](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4665256.svg)](https://doi.org/10.5281/zenodo.4665256)

> 50% of data science is copy + paste.
> The other 50% is figuring out what to copy + paste.

This aim of this book is to help a practitioner understand binary classification by providing a collection of scripts you can copy + paste into their project.
They should be fully annotated and self explanatory.
If more explanation is needed, submit an [issue](https://github.com/markanewman/DataScienceRecipes/issues) and I will look into it.
If you use the work in something that is public facing, adding a no-cite reference to my DOI is appreciated.

Right now this is an eBook.
I plan to release it to Amazon _sometime_ after my dissertation.
I find that writing this at the same time is helping me keep level.

To get your own copy of the ebook:
1. Clone the repo
2. Look in `~/00.book/07.examples.rmd` to find all the datasets used as examples.
   Download then copy them all to the `~/data` folder.
3. Knit the `~/00.book/00.index.rmd`
4. Use Edge to "print to PDF".

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
