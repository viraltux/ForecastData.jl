"""
Package: Forecast

    seaborne(query = "imports")

Return estimates of world seaborne trade from AIS data collected by Marine Traffic.

The data contains deadweight imports and exprts for France, Germany and the United Kingdom from 2015-04-01 to 2021-05-02. The fields are:

num_pc:     number of port calls
mtc:        metric tons of cargo
dwt:        deadweight tonnage
suffix_ma:  30-day moving averages

Data available at UN COMTRADE Monitor.Cerdeiro, Komaromi, Liu and Saeed (2020). 

# Arguments
- `query`: Defaults to "paper" and accepts the following values:
    - "full": Full original dataset from from 2015-04-01 to 2021-05-02
    - "imports": Subset with imports.


# Returns
Dataframe containing information based on the parameter `query`


# Examples
```julia-repl
julia> seaborne()
[ Info: Seaborne deadweight trade imports from AIS
2199×4 DataFrame
  Row │ Date        France   Germany  UK     
      │ Date        Int64    Int64    Int64  
──────┼──────────────────────────────────────
    1 │ 2015-04-01   507946   878377  599573
    2 │ 2015-04-02   332043  1501614  772714
    3 │ 2015-04-03   810077   941663  262994
   [...]
```
"""
function seaborne(query::String = "imports")

    @assert query in ["full","imports"]

    path = art_path("seaborne")
        
    sb_df = open(joinpath(path, "seaborne.csv")) do file
        CSV.read(file,DataFrame,
                 dateformat = "mm/dd/yyyy HH:MM:SS pp",
                 types = Dict(:year => Date))
    end

    if query == "full"
        @info "Full dataset with estimates of world seaborne trade from AIS"
        return sb_df
    end
    
    if query == "imports"
        @info "Seaborne deadweight trade imports from AIS"

        # Group by Country and Flow to select Imports
        gbt = groupby(sb_df, [:country_name, :flow], sort=true)
        return DataFrame(Dict(:Date => gbt[1].date ,
                              :UK => gbt[1].dwt, :Germany => gbt[3].dwt, :France => gbt[5].dwt))

    end
end
