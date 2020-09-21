## Read data from the mangal.io database

# read the id and other metadata of all ecological networks archived on mangal.io
# id: network ID
# S: number of species in the network
# L: number of interactions in the network
# P: number of interactions of predation in the network
# H: number of interactions of herbivory in the network

number_of_networks = count(MangalNetwork)
count_per_page = 100
number_of_pages = convert(Int, ceil(number_of_networks/count_per_page))

mangal_networks = DataFrame(fill(Int64, 5),
                 [:id, :S, :L, :P, :H],
                 number_of_networks)

global cursor = 1
@progress "Paging networks" for page in 1:number_of_pages
    global cursor
    networks_in_page = Mangal.networks("count" => count_per_page, "page" => page-1)
    @progress "Counting items" for current_network in networks_in_page
        S = count(MangalNode, current_network)
        L = count(MangalInteraction, current_network)
        P = count(MangalInteraction, current_network, "type" => "predation")
        H = count(MangalInteraction, current_network, "type" => "herbivory")
        mangal_networks[cursor,:] .= (current_network.id, S, L, P, H)
        cursor = cursor + 1
    end
end

CSV.write(joinpath("data", "raw", "mangal_networks.csv"), mangal_networks, append=true)
