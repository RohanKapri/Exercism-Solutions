## A Zipper lets the user traverse and update a tree
Zipper :: {
    focus : Tree,
    crumbs : List Crumb,
}.{
    Crumb :: [
        LeftCrumb U64 (Try Tree _),
        RightCrumb U64 (Try Tree _),
    ]

    ## A binary tree structure where each node holds an integer
    Tree := { value : U64, left ?: Tree, right ?: Tree }.{
        # The following line enables the default `is_eq` implementation
        is_eq : _

        ## get a zipper out of a tree, the focus is on the root node
        to_zipper : Tree -> Zipper
        to_zipper = |tree| {
            {
                focus: tree,
                crumbs: [],
            }
        }
    }

    # The following line enables the default `is_eq` implementation
    is_eq : _

    ## get the tree out of the zipper
    to_tree : Zipper -> Tree
    to_tree = |zipper| {
        helper = |z| {
            when up(z) is
                Ok(parent) -> helper(parent)
                Err(_) -> z
        }
        (helper(zipper)).focus
    }

    ## get the value of the focus node
    value : Zipper -> U64
    value = |zipper| {
        zipper.focus.value
    }

    ## move the focus to the current focus's left child, returns a new zipper
    left : Zipper -> Try(Zipper, _)
    left = |zipper| {
        when zipper.focus.left? is
            Ok(left_tree) ->
                right_child = zipper.focus.right?
                crumb = LeftCrumb zipper.focus.value right_child
                new_crumbs = List.append zipper.crumbs crumb
                Ok({
                    focus: left_tree,
                    crumbs: new_crumbs,
                })
            Err(_) -> Err(NoLeftChild)
    }

    ## move the focus to the current focus's right child, returns a new zipper
    right : Zipper -> Try(Zipper, _)
    right = |zipper| {
        when zipper.focus.right? is
            Ok(right_tree) ->
                left_child = zipper.focus.left?
                crumb = RightCrumb zipper.focus.value left_child
                new_crumbs = List.append zipper.crumbs crumb
                Ok({
                    focus: right_tree,
                    crumbs: new_crumbs,
                })
            Err(_) -> Err(NoRightChild)
    }

    ## move the focus to the parent, returns a new zipper
    up : Zipper -> Try(Zipper, _)
    up = |zipper| {
        when zipper.crumbs is
            [] -> Err(RootHasNoParent)
            [.. as rest, crumb] ->
                new_focus = when crumb is
                    LeftCrumb parent_val maybe_right ->
                        base = { value: parent_val, left: zipper.focus }
                        when maybe_right is
                            Ok(r) -> { base & right: r }
                            Err(_) -> base
                    RightCrumb parent_val maybe_left ->
                        base = { value: parent_val, right: zipper.focus }
                        when maybe_left is
                            Ok(l) -> { base & left: l }
                            Err(_) -> base

                Ok({
                    focus: new_focus,
                    crumbs: rest,
                })
    }

    ## set the value of the focus node, returns a new zipper
    set_value : Zipper, U64 -> Zipper
    set_value = |zipper, new_value| {
        new_focus = { zipper.focus & value: new_value }
        { zipper & focus: new_focus }
    }

    ## replace the left child, returns a new zipper
    set_left : Zipper, Tree -> Zipper
    set_left = |zipper, tree| {
        new_focus = { zipper.focus & left: tree }
        { zipper & focus: new_focus }
    }

    ## replace the right child, returns a new zipper
    set_right : Zipper, Tree -> Zipper
    set_right = |zipper, tree| {
        new_focus = { zipper.focus & right: tree }
        { zipper & focus: new_focus }
    }

    ## remove the left child, returns a new zipper
    remove_left : Zipper, Tree -> Zipper
    remove_left = |zipper, _tree| {
        new_focus = { zipper.focus & left?: none }
        { zipper & focus: new_focus }
    }

    ## remove the right child, returns a new zipper
    remove_right : Zipper, Tree -> Zipper
    remove_right = |zipper, _tree| {
        new_focus = { zipper.focus & right?: none }
        { zipper & focus: new_focus }
    }
}

