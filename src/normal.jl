
const normalfam = let
    loghval = log(1/sqrt(2π)) :: AbstractFloat
    logh(x::Real) = loghval :: AbstractFloat
    t(x::Real) = (x,x^2)
    function a(η::Tuple{Real, Real}) 
        η₁,η₂ = η
        -η₁^2 / 4η₂ - 0.5 * log(-2η₂)
    end
    NaturalExponentialFamily{Tuple{Real, Real},Real}(logh,t,a)
end

export normal
normal(μ,σ) = normalfam((μ/σ^2, -1/2σ^2))

