#include "speedywagon.h"
namespace speedywagon {
// Enter your code below:
// Please don't change the interface of the uv_light_heuristic function
int uv_light_heuristic(std::vector<int>* data_array) {
    double avg{};
    for (auto element : *data_array) {
        avg += element;
    }
    avg /= data_array->size();
    int uv_index{};
    for (auto element : *data_array) {
        if (element > avg) ++uv_index;
    }
    return uv_index;
}
bool connection_check (pillar_men_sensor * sensor) {
    if (sensor == nullptr){
        return false;
    } else {
        return true;
    }
}
int activity_counter (pillar_men_sensor* point, int capacity){
    int suma {0};
    for (int i = 0; i < capacity; i++){
        suma += point->activity;
        point++;
    }
    return suma;
}
bool alarm_control(pillar_men_sensor* point){
    if (point == nullptr){
        return false;
    } else {
        if(activity_counter(point,1)>0){
            return true;
        } else {
            return false;
        }
    }
}
bool uv_alarm(pillar_men_sensor* point){
    if (point == nullptr){
        return false;
    } else {
        if (uv_light_heuristic(&point->data)>point->activity){
            return true;   
        } else {
            return false;   
        }
    }
}
}  // namespace speedywagon
