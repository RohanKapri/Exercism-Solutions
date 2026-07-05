import ballerina/lang.'float;

public function score(float x, float y) returns int {
    float distance = 'float:sqrt(x * x + y * y);

    if distance > 10.0 {
        return 0;
    } else if distance > 5.0 {
        return 1;
    } else if distance > 1.0 {
        return 5;
    } else {
        return 10;
    }
}