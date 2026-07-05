import ballerina/lang.'array;

function allocateCubicles(int[] requests) returns int[] {
    map<boolean> assignedCubicles = {};
    int[] allocatedCubicles = [];

    foreach int cubicle in requests {
        string cubicleStr = cubicle.toString();
        if (!assignedCubicles.hasKey(cubicleStr)) {
            assignedCubicles[cubicleStr] = true;
            allocatedCubicles.push(cubicle);
        }
    }

    allocatedCubicles = 'array:sort(allocatedCubicles);
    return allocatedCubicles;
}