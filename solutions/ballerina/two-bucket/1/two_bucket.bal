import ballerina/io;

configurable boolean DEBUG = false;

# Determine how many actions are required to measure an exact number of liters
# by strategically transferring fluid between the buckets.
#
# + bucketOne - the size of the first bucket
# + bucketTwo - the size of the second bucket
# + goal - the desired number of litres to reach 
# + startBucket - the name of the first bucket to fill
# + return - a TestBucketResult record or an error
public function measure(int bucketOne, int bucketTwo, int goal, string startBucket) returns TwoBucketSolution|error {
    if bucketOne < goal && bucketTwo < goal {
        return error("goal is impossible");
    }

    var otherBucket = getOtherName(startBucket);
    var m = new Measure(bucketOne, bucketTwo, goal);
    m.fillBucket(startBucket);
    if m.getBucket(startBucket).capacity == goal {
        return m.getSolution() ?: error("unreachable");
    }
    if m.getBucket(otherBucket).capacity == goal {
        m.fillBucket(otherBucket);
        return m.getSolution() ?: error("unreachable");
    }
    foreach var _ in 0 ..< 20 {
        var solution = m.getSolution();
        if solution !is () {
            return solution;
        }
        if m.bucketIsFull(otherBucket) {
            m.emptyBucket(otherBucket);
        } else if m.bucketIsEmpty(startBucket) {
            m.fillBucket(startBucket);
        } else {
            m.pourBucket(otherBucket);
        }
        if m.buckets.every(it => it.amount == 0) {
            return error("goal is impossible");
        }
    }

    return error("goal is impossible");
}

function getOtherName(string bucketName) returns string {
    return bucketName == "one" ? "two" : "one";
}

class Measure {
    Bucket[] buckets;
    int goal;
    int moves = 0;

    function init(int bucketOne, int bucketTwo, int goal) {
        self.buckets = [new Bucket("one", bucketOne), new Bucket("two", bucketTwo)];
        self.goal = goal;
    }

    function pourBucket(string bucketName) {
        var bucketIx = self.getBucketIndex(bucketName);
        var otherBucketIx = (bucketIx + 1) % 2;
        self.pourBucketIx(bucketIx, otherBucketIx);
        self.logAction("pourBucket", bucketName);
    }

    function pourBucketIx(int bucketTo, int bucketFrom) {
        var fill = self.buckets[bucketFrom].pour(self.buckets[bucketTo].pour(self.buckets[bucketFrom].draw()));
        if fill > 0 {
            panic error("uncreachable");
        }
        self.moves += 1;
    }

    function emptyBucket(string bucketName) {
        var bucket = self.getBucket(bucketName);
        bucket.empty();
        self.moves += 1;
        self.logAction("emptyBucket", bucketName);
    }

    function fillBucket(string bucketName) {
        var bucket = self.getBucket(bucketName);
        bucket.fill();
        self.moves += 1;
        self.logAction("fillBucket", bucketName);
    }

    function getBucket(string bucketName) returns Bucket {
        var ix = self.getBucketIndex(bucketName);
        return self.buckets[ix];
    }

    function getBucketIndex(string bucketName) returns int {
        foreach var [ix, bucket] in self.buckets.enumerate() {
            if bucket.name == bucketName {
                return ix;
            }
        }
        panic error("unknown startBucket");
    }

    function getBucketGoal() returns Bucket? {
        foreach var bucket in self.buckets {
            if bucket.amount == self.goal {
                return bucket;
            }
        }
        return ();
    }

    function getSolution() returns TwoBucketSolution? {
        var goalBucket = self.getBucketGoal();
        if goalBucket !is () {
            return {
                otherBucket: self.getBucket(getOtherName(goalBucket.name)).amount,
                moves: self.moves,
                goalBucket: goalBucket.name
            };
        }
        return ();
    }

    function bucketIsFull(string bucketName) returns boolean {
        var bucket = self.getBucket(bucketName);
        return bucket.amount == bucket.capacity;
    }

    function bucketIsEmpty(string bucketName) returns boolean {
        var bucket = self.getBucket(bucketName);
        return bucket.amount == 0;
    }

    function logAction(string actionName, string bucketName, string? result = null) {
        if DEBUG {
            io:println(string `#[${self.moves}] ${actionName} "${bucketName}" => ${result ?: self.buckets.'map(it => string `(${it.amount}, ${it.capacity})`).toJsonString()}`);
        }
    }
}

class Bucket {
    string name;
    int capacity;
    int amount = 0;

    function init(string name, int capacity) {
        self.name = name;
        self.capacity = capacity;
    }

    function empty() {
        self.amount = 0;
    }

    function fill() {
        self.amount = self.capacity;
    }

    function pour(int amount) returns int {
        if self.amount + amount > self.capacity {
            var rest = self.amount + amount - self.capacity;
            self.amount = self.capacity;
            return rest;
        }
        self.amount += amount;
        return 0;
    }

    function draw() returns int {
        var amount = self.amount;
        self.empty();
        return amount;
    }
}