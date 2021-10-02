"""
Package: Forecast

    london()

Return ten years of monthly data about weather and crime in Greater London from 2008 to 2018.

Data has been collected and joined from london.gov.uk and metoffice.gov.uk (Heathrow Station).

# Weather Variables

- `MaxTemp`:  Mean daily maximum temperature in C°
- `MinTemp`:  Mean daily minimum temperature in C°
- `AirFrost`: Days of air frost
- `Rain`:     Total rainfall in mm
- `Sun`:      Total sunshine durationin hours

# Crime Variables and its aggregated categories
```
┌─────────────────────────────┬────────────────────────────────────────┐
│                       Crime │                               Category │
├─────────────────────────────┼────────────────────────────────────────┤
│                    Burglary │            Burglary in Other Buildings │
│                             │                 Burglary in a Dwelling │
│                      Damage │            Criminal Damage To Dwelling │
│                             │       Criminal Damage To Motor Vehicle │
│                             │      Criminal Damage To Other Building │
│                             │                  Other Criminal Damage │
│                       Drugs │                       Drug Trafficking │
│                             │                            Other Drugs │
│                             │                    Possession Of Drugs │
│                       Fraud │                     Counted per Victim │
│                             │                  Other Fraud & Forgery │
│                       Other │                         Going Equipped │
│                             │                       Other Notifiable │
│                     Robbery │                      Business Property │
│                             │                      Personal Property │
│                      Sexual │                           Other Sexual │
│                             │                                   Rape │
│                       Theft │                  Handling Stolen Goods │
│                             │ Motor Vehicle Interference & Tampering │
│                             │                            Other Theft │
│                             │                     Other Theft Person │
│                             │               Theft From Motor Vehicle │
│                             │                       Theft From Shops │
│                             │          Theft/Taking Of Motor Vehicle │
│                             │            Theft/Taking of Pedal Cycle │
│                    Violence │                    Assault with Injury │
│                             │                         Common Assault │
│                             │                   Grievous Bodily Harm │
│                             │                             Harassment │
│                             │                                 Murder │
│                             │                       Offensive Weapon │
│                             │                         Other violence │
│                             │                           Wounding/GBH │
└─────────────────────────────┴────────────────────────────────────────┘
```

# Returns
Dataframe containing the descrived dataset.

# Examples
```julia-repl
julia> london()
132×15 DataFrame
 Row │ Date        MaxTemp  MinTemp  AirFrost  
     │ Date        Float64  Float64  Int64     
─────┼─────────────────────────────────────────[...]
   1 │ 2008-01-01     10.4      4.7         0  
   2 │ 2008-02-01     11.0      2.0         7  
   3 │ 2008-03-01     10.6      3.7         2
   [...]
```
"""
function london()

    path = fdata("london")
    
    df = open(joinpath(path, "london.csv")) do file
        CSV.read(file,DataFrame,
                 dateformat = "yyyy-mm-dd",
                 types = Dict(:Date => Date))
    end
    
end
