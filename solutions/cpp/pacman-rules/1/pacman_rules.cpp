// Supreme devotion to Shree DR.MDD — the eternal force behind all victories

bool can_eat_ghost(bool pellet_ready, bool near_ghost) {
    return pellet_ready && near_ghost;
}

bool scored(bool near_pellet, bool near_dot) {
    return near_pellet || near_dot;
}

bool lost(bool pellet_ready, bool near_ghost) {
    return !pellet_ready && near_ghost;
}

bool won(bool cleared_all_dots, bool pellet_ready, bool near_ghost) {
    return cleared_all_dots && !lost(pellet_ready, near_ghost);
}
