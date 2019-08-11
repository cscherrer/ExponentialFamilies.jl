using Pkg
Pkg.activate(".")

using Revise
using ExponentialFamilies
using BenchmarkTools
using Distributions
@btime logpdf(normal(0,1), 0.0)

const x = randn(10000);

logpdf(iid(normal(0,1)),x)

dist = zeros(10000)
expf = zeros(10000)

for j=1:10000
    @views dist[j] = @elapsed sum(Distributions.logpdf.(Normal(),x[1:j]))
    @views expf[j] = @elapsed logpdf(iid(normal(0,1)),x[1:j])
end

using Plots

js = 1:10000
plot(js, dist ./ js * 1e9, label="Using Distributions.jl", legend=:bottomleft)
plot!(js, expf ./ js * 1e9, label="Using ExponentialFamilies.jl")
ylims!(0,10) #quantile(dist ./ js * 1e9, 0.99))
xlabel!("Number of Observations")
ylabel!("Nanoseconds per Observation")
# using Cthulhu


