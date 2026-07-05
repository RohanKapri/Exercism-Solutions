# Find the unique multiples of the given factors that are less than the limit.
# Return the sum of the multiples.
#
# + factors - an array of integers
# + 'limit - the upper limit of the multiples
# + return - the sum of the multiples
public function sum(int[] factors, int 'limit) returns int {
    map<boolean> uniqueMultiples = {};
    int sum = 0;

    foreach int factor in factors {
        if factor > 0 {
            foreach int i in int:range(factor, 'limit, factor){
                if uniqueMultiples[i.toString()] == () {
                    uniqueMultiples[i.toString()] = true;
                    sum += i;
                }
            }
        }
    }

    return sum;
}