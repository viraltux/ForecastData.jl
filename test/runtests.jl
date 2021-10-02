using ForecastData
using Test

@testset "ForecastData.jl" begin

    # co2
    data = co2()
    @test data isa DataFrame
    @test size(data) == (4609,2)

    data = co2(true)
    @test data isa DataFrame
    @test size(data) == (17166,17)

    # london
    data = london()
    @test data isa DataFrame
    @test size(data) == (132,15)

    # quakes
    data = quakes()
    @test data isa DataFrame
    @test size(data) == (71,2)

    #seaborne
    data = seaborne()
    @test data isa DataFrame
    @test size(data) == (2199,4)

    data = seaborne(true)
    @test data isa DataFrame
    @test size(data) == (13209,10)
    
end
