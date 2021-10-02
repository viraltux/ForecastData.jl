"""
Package: Forecast

    co2(full = false)

Return dataset with atmospheric Carbon Dioxide Dry Air Mole Fractions from quasi-continuous measurements at Mauna Loa, Hawaii.

K.W. Thoning, A.M. Crotwell, and J.W. Mund (2020), Atmospheric Carbon Dioxide Dry Air Mole Fractions from continuous measurements at Mauna Loa, Hawaii, Barrow, Alaska, American Samoa and South Pole. 1973-2019, Version 2020-08 National Oceanic and Atmospheric Administration (NOAA), Global Monitoring Laboratory (GML), Boulder, Colorado, USA https://doi.org/10.15138/yaf1-bk21 FTP path: ftp://aftp.cmdl.noaa.gov/data/greenhouse_gases/co2/in-situ/surface/

# Arguments
- `full`: if `true` Returns the full original dataset from 1973 to 2020 in a DataFrame, otherwise returns the subset used in "STL: A Seasonal-Trend Decomposition Procedure Based on Loess" from Cleveland et. al. Its default value is `false`.

# Returns
Dataframe containing the descrived dataset.

# Examples
```julia-repl
julia> co2()
[ Info: Dataset used in Cleveland et al. paper
4612×2 DataFrame
  Row │ date        co2        
      │ Date        Float64?   
──────┼────────────────────────
    1 │ 1974-05-17      333.38
    2 │ 1974-05-18      333.11
    3 │ 1974-05-19      333.46
   [...]
```
"""
function co2(full::Bool = false)

    path = art_path("co2")
    
    co2_df = open(joinpath(path, "co2.csv")) do file
        CSV.read(file,DataFrame)
    end

    if full
        @info "Full dataset from 1973 to 2020"
        return co2_df
    else
        @info "Dataset used in Cleveland et al. paper"
    end

    # recode missing values
    co2_df.value = replace(co2_df.value, -999.99 => missing)

    dates_co2 = Dates.Date(1973,1,1):Dates.Day(1):Dates.Date(2019,12,31)
    co2_sdf = DataFrame([dates_co2, co2_df.value],[:date,:co2])

    # paper dates
    # using 17 may instead 17 april (as the paper claims)
    # since there seems to be no data for april in 1974
    dates_co2_stl = Dates.Date(1974,5,17):Dates.Day(1):Dates.Date(1986,12,31)

    # revome leap year day
    dates_co2_stl = filter(dates_co2_stl) do x
        (Dates.isleapyear(x) & (Dates.month(x) == 2)) ? Dates.day(x) != 29 : true
    end

    @subset(co2_sdf, in.(:date,  Ref(dates_co2_stl)))
    
end
