# ForecastData

This package handles access to small to medium size time series datasets (in the Megabytes) to be used in Julia.

Since the number of datasets could be potentially large and relatively big in size they are not downloaded when the package is installed, but only when they are called to then be stored locally as a Julia artifact.

The format chosen to return the time series is via a [DataFrame](https://dataframes.juliadata.org/stable/) with its first column using [Dates](https://docs.julialang.org/en/v1/stdlib/Dates/) when appropiate.

In general time series available in ForecastData will be "unique" in one of these two ways:
- They are a combination of publicly available datasets (e.g. `london` dataset) 
- They are publicly available datasets with some preparation to facilitate their use (e.g. `quakes` dataset)
	
Simple publicly available datasets will not be generally considered, for instance [R](https://cran.r-project.org) datasets like  `AirPassengers` will not be stored in ForecastData since they can be easily accessed via [RCall](https://github.com/JuliaInterop/RCall.jl).

The current available datasets are:

| Name | Description |  
|---|---
|**co2** | Atmospheric Carbon Dioxide Dry Air Mole Fractions from quasi-continuous measurements at Mauna Loa, Hawaii from 1973 to 2020
|**london** | Monthly data on weather and crime in Greater London from 2008 to 2018
|**quakes** | Earthquakes with a magnitude higher or equal to six from 1638-06-11 to 2021-10-02
|**seaborne** | Seaborne trade for France, Germany and the United Kingdom from 2015-04-01 to 2021-05-02

# Examples

```julia
using ForecastData
co2_ts = co2("paper")

[ Info: Dataset used in Cleveland et al. paper
4609×2 DataFrame
  Row │ date        co2        
      │ Date…       Float64?   
──────┼────────────────────────
    1 │ 1974-05-17      333.38
    2 │ 1974-05-18      333.11
    3 │ 1974-05-19      333.46
[...]
```

# Contributions
if you would like to contribute new datasets to the package please consider a Pull Request with the following actions:

- Create a data/[new_dataset].tar.gz file with a [new_dataset].md description file.
- Create a src/[new_dataset].jl file
- Create a test/[new_dataset].jl file
- Update the README.md and Forecast.jl files with the new dataset information
- Update Artifacts.toml with the new dataset

---
[![Build Status](https://github.com/viraltux/ForecastData.jl/workflows/CI/badge.svg)](https://github.com/viraltux/ForecastData.jl/actions)
[![Coverage](https://codecov.io/gh/viraltux/ForecastData.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/viraltux/ForecastData.jl)
