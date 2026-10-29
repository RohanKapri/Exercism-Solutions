TrainRoute :: {}.{
    Route : List(U32)

    # Create a new empty train route
    new : -> Route
    new = || []

    # Get the number of stations on the route
    len : Route -> U64
    len = |route| List.len(route)

    # Check if the route has no stations
    is_empty : Route -> Bool
    is_empty = |route| List.is_empty(route)

    # Extend the route by adding a station to the beginning
    push_front : Route, U32 -> Route
    push_front = |route, station| List.prepend(route, station)

    # Extend the route by adding a station to the end
    push_back : Route, U32 -> Route
    push_back = |route, station| List.append(route, station)

    # Shorten the route by removing the station at the beginning
    pop_front : Route -> { route : Route, station : Result(U32, [ListWasEmpty]) }
    pop_front = |route|
        when List.first(route) is
            Ok(station) ->
                rest = List.drop_first(route, 1)
                { route: rest, station: Ok(station) }
            Err(ListWasEmpty) ->
                { route: route, station: Err(ListWasEmpty) }

    # Shorten the route by removing the station at the end
    pop_back : Route -> { route : Route, station : Result(U32, [ListWasEmpty]) }
    pop_back = |route|
        when List.last(route) is
            Ok(station) ->
                rest = List.drop_last(route, 1)
                { route: rest, station: Ok(station) }
            Err(ListWasEmpty) ->
                { route: route, station: Err(ListWasEmpty) }

    # Remove a specific closed station from anywhere along the route
    remove : Route, U32 -> Route
    remove = |route, station_to_remove|
        List.keep_if(route, |station| station != station_to_remove)
}