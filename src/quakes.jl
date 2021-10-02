"""
Package: Forecast

    quakes()

Return the number of earthquakes per year on earth with a magnitude higher or equal to six from 1950 to 2020. The data has been collected from https://earthquake.usgs.gov/ and aggregated.

# Examples
```julia-repl
julia> quakes()
71×2 DataFrame
 Row │ year        quakes 
     │ Date        Int64  
─────┼────────────────────
   1 │ 1950-01-01     138
   2 │ 1951-01-01     151
   3 │ 1952-01-01     181
   [...]
```
"""
function quakes()

    path = fdata("quakes")
    
    open(joinpath(path, "quakes.csv")) do file
        CSV.read(file,DataFrame,
                 dateformat = "yyyy",
                 types = Dict(:year => Date))
    end
    
end
