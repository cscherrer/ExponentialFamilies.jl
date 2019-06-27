module ExponentialFamilies

struct ExponentialFamily{P,X,N}
    logh # :: X -> Real
    logg # :: P -> Real
    η    # :: P -> StaticVector{N, Real}
    t    # :: X -> StaticVector{N, Real}
end

struct ExpFamDist{P,X,N}
    fam :: ExponentialFamily{P,X,N}
    θ :: P
end

logpdf(d::ExpFamDist, x) = d.fam.logh(x) + d.fam.logg(d.θ) + d.fam.η(d.θ) * d.fam.t(x)

end # module
