"""
Package: Forecast

    quakes()

Return dagta about earthquakes with a magnitude higher or equal to six from 1638-06-11 to 2021-10-02. The data has been collected from https://earthquake.usgs.gov/ 

# Arguments
- `full`: if `true` Returns the full original dataset DataFrame, otherwise 


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
function quakes(query::String = "count")

    @assert query in ["full","count"]

    path = art_path("quakes")

    qk_df = open(joinpath(path, "quakes.csv")) do file
        CSV.read(file,DataFrame,
                 dateformat = "yyyy-mm-ddTHH:MM:SS.sssZ",
                 types = Dict(:time => Date))
    end

    if query == "full"
        @info "Full dataset from 1638-06-11 to 2021-10-02"
        return qk_df
    end

    if query == "count"
        @info "Number of earthquakes per year"
        qk_df = DataFrame(reshape(Dates.year.(qk_df.time),:,1),:auto)

        db = SQLite.DB();
        Q = q -> DBInterface.execute(db, q);

        qk_df |> SQLite.load!(db, "qk_df", temp=false);

        query_count = """select x1 as year, count(*) as total_quakes
                                 from qk_df
                                 group by x1
                                 order by x1"""
        
        return Q(query_count)  |> DataFrame

    end

end
