## Maximum entropy degree distribution of a food web with S species

# number of species
S = 150

# predicted number of links (using all the posterior distribution of the flexible links model)
links_rdm = predict_L(S)

# median, 67%, 89%, and 97% PI of predicted number of links
links_500 = Int64(median(links_rdm))
links_015 = Int64(quantile(links_rdm, 0.015))
links_055 = Int64(quantile(links_rdm, 0.055))
links_165 = Int64(quantile(links_rdm, 0.165))
links_835 = Int64(quantile(links_rdm, 0.835))
links_945 = Int64(quantile(links_rdm, 0.945))
links_985 = Int64(quantile(links_rdm, 0.985))

# degree distributions of those predicted numbers of links
dd_500 = maxent_dd(S, links_500)
dd_015 = maxent_dd(S, links_015)
dd_055 = maxent_dd(S, links_055)
dd_165 = maxent_dd(S, links_165)
dd_835 = maxent_dd(S, links_835)
dd_945 = maxent_dd(S, links_945)
dd_985 = maxent_dd(S, links_985)

# mean degrees
md = 2 .* links_rdm ./ S
md_500 = 2 * links_500 / S
md_015 = 2 * links_015 / S
md_055 = 2 * links_055 / S
md_165 = 2 * links_165 / S
md_835 = 2 * links_835 / S
md_945 = 2 * links_945 / S
md_985 = 2 * links_985 / S


## plots

# palette
pal_median = RGB(204/255,121/255,167/255)

# plot mean degrees (distribution of constraints)
density(md, color=:black, linewidth=2, label="",  framestyle=:box, dpi=200)
plot!([md_015, md_985], [0.03, 0.03], fill=(0, :grey, 0.12), c=:transparent, lab="")
plot!([md_500], st=:vline, color=pal_median, ls=:solid, lw=1, lab="")
plot!([md_015], st=:vline, color=:grey, ls=:dot, lw=1, lab="")
plot!([md_055], st=:vline, color=:grey, ls=:dash, lw=1, lab="")
plot!([md_165], st=:vline, color=:grey, ls=:solid, lw=1, lab="")
plot!([md_835], st=:vline, color=:grey, ls=:solid, lw=1, lab="")
plot!([md_945], st=:vline, color=:grey, ls=:dash, lw=1, lab="")
plot!([md_985], st=:vline, color=:grey, ls=:dot, lw=1, lab="")
xaxis!(xlabel="mean degree (links / species)", xlims=(0,S))
yaxis!(ylabel="probability density", ylims=(0,0.03))

savefig(joinpath("fig","md_150"))


# plot maximum entropy degree distributions
a = [1,2,5,10,30,100] # for x-axis (needs to be changed depending on the value of S)

plot(dd_015, color=:black, alpha=0.7, linewidth=2, linestyle=:dot, label="97% PI", # 97% PI
     framestyle=:box, foreground_color_legend=nothing, background_color_legend=:white, dpi=200)
plot!(dd_055, color=:black, alpha=0.7, linewidth=2, linestyle=:dash, label="89% PI") # 89% PI
plot!(dd_165, color=:black, alpha=0.7, linewidth=2, linestyle=:solid, label="67% PI") # 67% PI
plot!(dd_835, color=:grey, alpha=0.7, linewidth=1.5, linestyle=:solid, label="") # 67% PI
plot!(dd_945, color=:grey, alpha=0.7, linewidth=1.5, linestyle=:dash, label="") # 89% PI
plot!(dd_985, color=:grey, alpha=0.7, linewidth=1.5, linestyle=:dot, label="") # 97% PI
plot!(dd_500, color=pal_median, linewidth=4, label="median")
xaxis!(:log, xlabel="k", xticks=(a, a), xlims=(1,S))
yaxis!(ylabel="p(k)", ylims=(0,0.25))

savefig(joinpath("fig","dd_150"))
