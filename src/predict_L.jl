## Predicted number of links in a food web using the flexible links model

function links_muphi(mu::Float64, phi::Float64, S::Int64, n::Int64)
    # mu and phi: parameters of the flexible links model
    # S: number of species
    # n: number of simulation

    # simulate total number of links for specific mu and phi

    # parameters alpha and beta
    α = mu*phi
    β = (1.0-mu)*phi

    # beta-binomial distribution
    bb = BetaBinomial(S^2-S+1, α, β)

    # simulate total number of links
    links_rdm = rand(bb, n) .+ S .- 1

    return links_rdm
end


function predict_L(S)
    # S: number of species

    # simulate total number of links for the entire joint posterior distribution

    # empty vector
    links_rdm_post = Vector{Int64}()

    # simulate over the joint posterior distribution
    for i in 1:length(mu_post)
        append!(links_rdm_post, links_muphi(mu_post[i], phi_post[i], S, 1000))
    end

    return shuffle(links_rdm_post)
end
