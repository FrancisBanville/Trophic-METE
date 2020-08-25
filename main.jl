# Activate project environment
import Pkg; Pkg.activate(".")

Pkg.instantiate()

# Load required packages
using CSV
using Distributions
using EcologicalNetworks
using Mangal
using Plots
using Random
using StatsPlots
using StatsBase

# Load functions 
include("src/predict_L.jl")
include("src/maxent_dd.jl")
include("src/empirical_dd.jl")

# Make figures
include("scripts/01_flexible_links_posterior.jl")
include("scripts/02_dd_theoretical_fw.jl")
include("scripts/03_dd_mangal_fw.jl")
