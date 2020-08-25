## Compute the degree distribution p_k from a vector of degrees

function empirical_dd(degrees)
    # degrees: degrees of each node in a network

    # return proportion of nodes of degree k in a network

    # empty vector for degree distribution
    degrees = Int64.(degrees)
    dd = zeros(maximum(degrees),2)
    dd[:,1] = 1:maximum(degrees)

    # propotion of nodes of degree k
    for i in 1:maximum(degrees)
        dd[i,2] = length(degrees[degrees .== i]) / length(degrees)
    end

    # remove degree 0
    dd = dd[dd[:,2] .> 0, :]

    return dd
end
