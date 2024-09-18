const max_cluster_num = 5
#=
modes_here
 e.g m.pfms_test[2][(m1 = 4, m2 = 3)]
     m.pfms_test[3][(m1 = 2, m2 = 1, m3 = 3)]
=#
function get_distance_mat(modes_here)
    first_key = first(keys(modes_here))
    distance_mat = zeros(Int, (length(modes_here), length(first_key)))
    for (ind, _key_) in enumerate(keys(modes_here))
        distance_mat[ind, :] .= values(_key_)
    end
    return distance_mat
end

function get_weights_and_distance_mat(modes_here)
    weights, distance_mat = nothing, nothing
    if length(modes_here) ≤ max_cluster_num
        counts_each = Vector{Int}(undef, length(modes_here))
        for (ind,_key_) in enumerate(keys(modes_here))
            counts_each[ind] = Int(sum(@view modes_here[_key_][:, 1]))
        end
        weights = counts_each ./ sum(counts_each)
        distance_mat = get_distance_mat(modes_here)
    else
        # do clustering
        all_distance_mats = get_distance_mat(modes_here)
        weights, distance_mat = return_cluster_centers_and_weights(all_distance_mats)
    end
    return weights, distance_mat
end
