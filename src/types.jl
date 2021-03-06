struct NaturalExponentialFamily{P,X}
    logh :: Function # :: X -> Real
    t    :: Function # :: X -> StaticVector{N, Real}
    a    :: Function # :: P -> Real
end

struct NatExpFamDist{P,X}
    fam :: NaturalExponentialFamily{P,X}
    # a :: Real # may add this back in later
    η :: P
end


export partype
partype(::Type{NaturalExponentialFamily{P,X}}) where {P,X} = P 
partype(::Type{NatExpFamDist{P,X}}) where {P,X} = P 

export eltype
eltype(::Type{NaturalExponentialFamily{P,X}}) where {P,X} = X
eltype(::Type{NatExpFamDist{P,X}}) where {P,X} = X


export logpdf
function Distributions.logpdf(d::NatExpFamDist{P,X}, x::X)::Real where {P,X} 
    d.fam.logh(x) + d.η ⋅ d.fam.t(x) - d.fam.a(d.η)
end


function Distributions.logpdf(d::NatExpFamDist{P,X}, x)::Real where {P,X} 
    d.fam.logh(x) + d.η ⋅ d.fam.t(x) - d.fam.a(d.η)
end

function (fam::NaturalExponentialFamily{P,X})(η::P) where {P,X}
    NatExpFamDist{P,X}(fam, η)
end

export iid
function iid(d::NatExpFamDist{P,X} ) where {P,X}
    logh(xs :: AbstractArray{<:X}) = sum(d.fam.logh.(xs))
    t(xs :: AbstractArray{<:X}) = reduce((a,b) -> a .+ b,d.fam.t.(xs))
    a(η::P) = d.fam.a(η)

    fam = NaturalExponentialFamily{P,AbstractArray{X}}(logh, t, a)
    NatExpFamDist(fam,d.η)
end
    
    