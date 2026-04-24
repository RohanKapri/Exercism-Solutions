@namespace "listops"
function len(a,  i, n) { for (i in a) ++n; return n }
# Append to a list all the elements of another list.
# Or append to a list a single new element
function append(list, item_or_list,  n, m, i) {
  n = len(list)
  if (!awk::isarray(item_or_list)) {
    list[n + 1] = item_or_list; return }
  m = len(item_or_list)
  for (i = 1; i <= m; ++i) list[++n] = item_or_list[i] }
# Concatenate is flattening a list of lists one level
function concat(list, result,  n, m, i, j, k) {
  n = len(list)
  for (i = 1; i <= n; ++i) {
    m = len(list[i])
    for (j = 1; j <= m; ++j) result[++k] = list[i][j] } }
# Only the list elements that pass the given function.
function filter(list, funcname, result,  n, m, i) {
  n = len(list)
  for (i = 1; i <= n; ++i)
    if (@funcname(list[i])) result[++m] = list[i] }
# Transform the list elements, using the given function, into a new list.
function map(list, funcname, result,  n, i) {
  n = len(list)
  for (i = 1; i <= n; ++i) result[i] = @funcname(list[i]) }
# Left-fold the list using the function and the initial value.
function foldl(list, funcname, initial,  n, i) {
  n = len(list)
  for (i = 1; i <= n; ++i) initial = @funcname(initial, list[i])
  return initial }
# Right-fold the list using the function and the initial value.
function foldr (list, funcname, initial,  i) {
  for (i = len(list); i > 0; --i) initial = @funcname(list[i], initial)
  return initial }
# the list reversed
function reverse (list, result,  n, i) {
  n = len(list)
  for (i = 1; i <= n; ++i) result[i] = list[n - i + 1] }
