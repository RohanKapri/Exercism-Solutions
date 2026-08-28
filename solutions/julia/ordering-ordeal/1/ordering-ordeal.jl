function sortquantity!(qty)
    i = sortperm(qty, rev=true)
    sort!(qty, rev=true)
    return i
end

function sortcustomer(cust, srtperm)
    cust[srtperm]
end

function production_schedule!(cust, qty)
    i = sortquantity!(qty)
    sortcustomer(cust, i), sortperm(i)
end