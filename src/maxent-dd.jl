## Maximum entropy degree distribution of a network with S species and L links

function p_k(k::Int64, S::Int64, L::Int64)
    # k: degree of a species
    # S: number of species in the food web
    # L: number of links in the food web

    # return probability of degree k from MaxEnt distribution
    # p_k = c * r^k

    # constraint of mean
    mean_degree = (2 * L) / S

    # maximum entropy distribution
    c = 1 / (mean_degree - 1)
    r = (mean_degree - 1) / mean_degree

    return c * r ^ k
end



function degree_dist(; S::Int64, L::Int64)
    # S: number of species
    # L: number of links

    # return degree distribution with maximum entropy
    # i.e. probability for each k between 1 and S
    degree_dist = zeros(S)
    for k in 1:S
        degree_dist[k] = p_k(k, S, L)
    end

    return degree_dist
end
