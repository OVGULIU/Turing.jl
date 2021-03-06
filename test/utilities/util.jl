using Turing, Random, Test
using Turing: @VarName, randcat
using Distributions: Normal
using StatsFuns

include("../test_utils/AllUtils.jl")

@turing_testset "util.jl" begin
    i = 1
    @test @VarName(s)[1:end-1] == (:s,())
    @test @VarName(x[1,2][1+5][45][3][i])[1:end-1] ==
        (:x,("[1, 2]","[6]","[45]","[3]","[1]"))
    @test StatsFuns.logistic(1.1) == 1.0 / (exp.(-1.1) + 1.0)
    @test StatsFuns.logit(0.3) ≈ -0.8472978603872036 atol=1e-9
    @test isnan.(StatsFuns.logit(1.0)) == false
    @test isinf.(StatsFuns.logit(1.0)) == true
    @test isnan.(StatsFuns.logit(0.)) == false
    @test isinf.(StatsFuns.logit(0.)) == true
    randcat([0.1, 0.9])

    @test Turing.data(Dict(:y => 1, :x => 2, :z => 1), [:x, :y]) ==
        (x = 2, y = 1)
end
