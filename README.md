# ForecastData

This package stores small to medium size time series datasets (in the Megabytes) to be used in Julia.

Since the number of datasets could be potentially large and relatively big in size they are not downloaded when the package is installed, but only when they are called to then be stored locally as a Julia artifact.

The format chosen to return the time series is via a [DataFrame](https://dataframes.juliadata.org/stable/) with its first column using [Dates](https://docs.julialang.org/en/v1/stdlib/Dates/)

In general time series available in ForecastData will be "unique" in one of these two ways:
	- They are a combination of publicly available datasets (e.g. `london` dataset) 
	- They are a publicly available dataset with some preparation to facilitate its use (e.g. `quakes` dataset)
	
Simple publicly available datasets will not be generally considered, for instance [R](https://cran.r-project.org) datasets like  `AirPassengers` will not be stored in ForecastData since they can be easily accessed via [RCall](https://github.com/JuliaInterop/RCall.jl).

The current available datasets are:

| Name | Description |  
|---|---
|**co2** | Atmospheric carbon dioxide
|**london** | Weather and crime in Greater London
|**quakes** | Earthquakes around the world
|**seaborne** | World seaborne trade

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

[![Build Status](https://github.com/viraltux/ForecastData.jl/workflows/CI/badge.svg)](https://github.com/viraltux/ForecastData.jl/actions)
[![Coverage](https://codecov.io/gh/viraltux/ForecastData.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/viraltux/ForecastData.jl)
