## Posterior distribution of the flexible links model (applied to all food webs archived in Mangal)

# counterfactuals and posterior distribution of flexible links model
fl_post = CSV.read(joinpath("data", "sims", "beta_binomial_posterior.csv"))

# parameters mu and phi from the entire joint posterior distribution
mu_post = fl_post[:,:mu]
phi_post = exp.(fl_post[:,:phi])
