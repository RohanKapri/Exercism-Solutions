module [get_user, parse_user_id, get_page, error_message]

User : { name : Str }
UserId : U64

users : Dict UserId User
users =
    Dict.from_list [
        (123, { name: "Alice" }),
        (456, { name: "Bob" }),
        (789, { name: "Charlie" }),
    ]

get_user : UserId -> Result User [UserNotFound UserId]
get_user = \user_id ->
    when Dict.get users user_id is
        Ok user -> Ok user
        Err KeyNotFound -> Err (UserNotFound user_id)

parse_user_id : Str -> Result UserId [InvalidUserId Str]
parse_user_id = \user_id_str ->
    Str.to_u64 user_id_str
    |> Result.map_err \_ -> InvalidUserId user_id_str

get_page : Str -> Result Str [InsecureConnection Str, InvalidDomain Str, PageNotFound Str, InvalidUserId Str, UserNotFound UserId]
get_page = \url ->
    # Split protocol from rest in one operation
    when Str.split_first url "://" is
        Ok { before: protocol, after: rest } ->
            if protocol != "https" then
                Err (InsecureConnection url)
            else
                # Split domain from path in one operation
                when Str.split_first rest "/" is
                    Ok { before: domain, after: path_without_slash } ->
                        if domain != "example.com" then
                            Err (InvalidDomain url)
                        else
                            # Reconstruct path with leading slash
                            path = "/$(path_without_slash)"
                            route path

                    Err NotFound ->
                        # No slash after domain (e.g., "https://example.com")
                        if rest == "example.com" then
                            Err (PageNotFound "")
                        else
                            Err (InvalidDomain url)

        Err NotFound ->
            # No protocol separator found
            Err (InsecureConnection url)

route : Str -> Result Str [PageNotFound Str, InvalidUserId Str, UserNotFound UserId]
route = \path ->
    when path is
        "/" -> Ok "Home page"
        "/users/" -> Ok "Users page"
        _ ->
            # Check if path starts with "/users/" (9 characters)
            if Str.starts_with path "/users/" then
                user_id_str = Str.drop_prefix path "/users/"
                when parse_user_id user_id_str is
                    Ok user_id ->
                        when get_user user_id is
                            Ok user -> Ok "$(user.name)'s page"
                            Err (UserNotFound id) -> Err (UserNotFound id)

                    Err _ -> Err (InvalidUserId user_id_str)
            else
                Err (PageNotFound path)

error_message : [InsecureConnection Str, InvalidDomain Str, PageNotFound Str, InvalidUserId Str, UserNotFound UserId], [English] -> Str
error_message = \err, _language ->
    when err is
        InsecureConnection url -> "Insecure connection (non HTTPS): $(url)"
        InvalidDomain url -> "Invalid domain name: $(url)"
        PageNotFound path -> "Page not found: $(path)"
        InvalidUserId user_id_str -> "User ID is not a positive integer: $(user_id_str)"
        UserNotFound user_id -> "User #$(Num.to_str user_id) was not found"