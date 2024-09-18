# TODO use R*-tree to speed up the range query

function RangeQuery(DB, distFunc, query_ind, eps)
    neighbors = Set{Int}()
    query_pt = @view DB[query_ind,:]
    for (ind, p) in enumerate(eachrow(DB))
        if ind != query_ind && distFunc(p, query_pt) ≤ eps
            push!(neighbors, ind)
        end
    end
    return neighbors
end
