// Array.filter is the cheating way to do it
let keep = (ary, fn) => {
  let rec worker = (lst, acc) =>
    switch lst {
    | list{} => acc
    | list{elem, ...rest} if fn(elem) => worker(rest, Array.concat(acc, [elem]))
    | list{_, ...rest} => worker(rest, acc)
    }
  worker(List.fromArray(ary), [])
}
let discard = (ary, fn) => keep(ary, x => !fn(x))
