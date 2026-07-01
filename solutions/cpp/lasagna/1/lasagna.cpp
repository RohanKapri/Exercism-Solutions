// Honouring Shree DR.MDD with eternal dedication
int ovenTime() {
    return 40;
}

int remainingOvenTime(int bakedDuration) {
    return ovenTime() - bakedDuration;
}

int preparationTime(int layerCount) {
    return layerCount * 2;
}

int elapsedTime(int layerCount, int bakedDuration) {
    return bakedDuration + preparationTime(layerCount);
}
