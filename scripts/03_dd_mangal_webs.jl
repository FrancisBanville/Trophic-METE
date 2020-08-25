## Empirical evaluation of our model (comparison with 6 largest food webs archived on Mangal)

# read metadata of networks archieved on Mangal
mangal_networks = CSV.read(joinpath("data", "raw", "mangal_networks.csv"))

# filter for food webs (predation or herbivory links) archieved on Mangal
mangal_fw = mangal_networks[(mangal_networks[:,:P] .> 0) .| (mangal_networks[:,:H] .> 0), :]

# sort by species richness and filter for 6 largest webs
sort!(mangal_fw, :S, rev=true)
fw_large = first(mangal_fw, 6)

# convert these large food webs to unipartite networks
fw_large_UN = convert.(UnipartiteNetwork, network.(fw_large.id))


# number of species and links in the networks
fw_large_S = richness.(fw_large_UN)
fw_large_L = links.(fw_large_UN)

# empirical degree distributions
fw_large_dd = values.(degree.(fw_large_UN))

# maxent distributions
dd_maxent = maxent_dd.(fw_large_S, fw_large_L)

# empirical degree distributions of 6 largest food webs
dd_emp = empirical_dd.(fw_large_dd)


## plots

# plot empirical and maxent degree distributions
function plot_dd(dd_emp, dd_maxent)
    scatter(dd_emp[:,1], dd_emp[:,2], color=:grey, alpha=0.4, label="", markersize=2,
    framestyle=:box, dpi=200)
    plot!(dd_maxent, color=pal_median, linewidth=2, linestyle=:solid, label="")
    xaxis!(xlabel="k", xlims=(0, maximum(dd_emp[:,1])+5))
    yaxis!(ylabel="p(k)", ylims=(0,maximum(dd_emp[:,2])*1.1))
end

plot_dd1 = plot_dd(dd_emp[1], dd_maxent[1])
plot_dd2 = plot_dd(dd_emp[2], dd_maxent[2])
plot_dd3 = plot_dd(dd_emp[3], dd_maxent[3])
plot_dd4 = plot_dd(dd_emp[4], dd_maxent[4])
plot_dd5 = plot_dd(dd_emp[5], dd_maxent[5])
plot_dd6 = plot_dd(dd_emp[6], dd_maxent[6])


plot(plot_dd1, plot_dd2, plot_dd3, plot_dd4, plot_dd5, plot_dd6, layout=(2,3),
    legend=false,
    title=["S=$(fw_large_S[i]), L=$(fw_large_L[i])" for j in 1:1, i in 1:6], titleloc=:right, titlefont=font(6))

savefig(joinpath("fig", "emp_dd"))
