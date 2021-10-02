module ForecastData

using Pkg.Artifacts
using CSV, DataFrames, DataFramesMeta, Dates, Downloads, Inflate, RCall, SQLite, Tar


include("art_path.jl")

# Datasets
include("co2.jl")
export co2

include("seaborne.jl")
export seaborne

include("quakes.jl")
export quakes

include("london.jl")
export london



"""
List of available dataset functions:

| Name | Description |  
|---|---
|**co2** | Atmospheric carbon dioxide
|**london** | Weather and crime in Greater London
|**quakes** | Number of earthquakes
|**seaborne** | World seaborne trade
"""
ForecastData

end
