"""
DBSCAN
DB: A n x p data matrix where p is the 
    number features and n the number of datapoints

    return labels: A vector of length n where each element
        is a cluster number or -1 if the point is noise
"""
function DBSCAN(DB, ;distFunc=euc_dist, eps=10, minPts=3)
    C = 0           # cluster counter
    N = size(DB, 1) # 
    labels = zeros(Int, N) # labels: 0 - unclassified, -1 - noise, 1, 2, ... - cluster number

    for query_ind = 1:N
        labels[query_ind] != 0 && continue
        neighbors = RangeQuery(DB, distFunc, query_ind, eps)
        if length(neighbors)+1 < minPts  # +1 to include query_ind
            labels[query_ind] = -1 # noise
            continue
        end
        C += 1
        labels[query_ind] = C
        S = neighbors
        while !isempty(S)
            neighbor_ind = pop!(S)
            labels[neighbor_ind] == -1 && (labels[neighbor_ind] = C) # change noise to border point
            labels[neighbor_ind] != 0  && continue # previously processed
            labels[neighbor_ind] = C
            neighbors_there = RangeQuery(DB, distFunc, neighbor_ind, eps)
            if length(neighbors_there)+1 ≥ minPts
                S = union(S, neighbors_there)
            end
        end
    end
    return labels
end


"""
return the weights and cluster centers
"""
function return_cluster_centers_and_weights(DB, labels)
    # sort the unique labels from small to large
    labels_uniq_sorted = sort!(unique(labels))
    cluster_means = zeros(eltype(DB), length(labels_uniq_sorted), size(DB, 2))
    for (ind, label) in enumerate(labels_uniq_sorted)
        mean_here = (@view DB[labels .== label,:]) |> mean 
        cluster_means[ind,:] .= Int.(ceil.(mean_here))
    end
    counts_each = [sum(labels .== i) for i in labels_uniq_sorted] 
    weights = counts_each ./ sum(counts_each)    
    return weights, cluster_means
end

function return_cluster_centers_and_weights(DB; eps=10)
    labels = DBSCAN(DB; eps=eps)
    return return_cluster_centers_and_weights(DB, labels)
end