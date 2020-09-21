# Activate project environment
import Pkg; Pkg.activate(".")

Pkg.instantiate()

# Load required packages
using CSV
using DataFrames
using Distributions
using EcologicalNetworks
import Mangal
using Plots
using Random
using StatsPlots
using StatsBase

# Load functions
include("src/predict_L.jl")
include("src/maxent_dd.jl")
include("src/empirical_dd.jl")

# Make figures
include("scripts/00_import_mangal_data.jl")
include("scripts/01_flexible_links_posterior.jl")
include("scripts/02_dd_speculative_webs.jl")
include("scripts/03_dd_mangal_webs.jl")
