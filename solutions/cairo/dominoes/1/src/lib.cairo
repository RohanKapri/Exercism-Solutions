use core::array::ArrayTrait;
use core::dict::Felt252Dict;
use core::option::{Option, OptionTrait};
use core::traits::{Into, TryInto};

pub type Domino = (u8, u8);

/// Build a proper closed domino chain using all stones exactly once,
/// or return None if impossible.
pub fn chain(dominoes: @Array<Domino>) -> Option<Array<Domino>> {
    // Trivial case
    if dominoes.len() == 0 {
        return Option::Some(array![]);
    }

    // Build multigraph: edge counts, degree per vertex, and the set of used vertices.
    let mut edges: Felt252Dict<u32> = Default::default();
    let mut degree: Felt252Dict<u32> = Default::default();
    let mut seen: Felt252Dict<bool> = Default::default();
    let mut verts: Array<u8> = array![];

    let mut i: usize = 0;
    let n = dominoes.len();
    while i < n {
        let (a, b) = *dominoes.at(i);
        i += 1;

        // Count this undirected edge
        let (x, y) = norm_pair(a, b);
        let key = pack_pair(x, y);
        let c = edges.get(key);
        edges.insert(key, c + 1_u32);

        // Degrees (loop adds two)
        let da = degree.get(a.into());
        degree.insert(a.into(), da + 1_u32);
        let db = degree.get(b.into());
        degree.insert(b.into(), db + 1_u32);

        // Remember seen vertices
        if !seen.get(a.into()) {
            seen.insert(a.into(), true);
            verts.append(a);
        }
        if !seen.get(b.into()) {
            seen.insert(b.into(), true);
            verts.append(b);
        }
    };

    // Fast feasibility checks for a closed chain:
    if !all_even_degrees(@verts, ref degree) {
        return Option::None;
    }

    if !is_connected(@verts, ref edges) {
        return Option::None;
    }

    // Construct Eulerian circuit via Hierholzer
    let start = *verts.at(0);
    let mut circuit_vertices: Array<u8> = array![];
    hierholzer(start, @verts, ref edges, ref circuit_vertices);

    // Convert successive vertices into oriented dominoes
    let mut out: Array<Domino> = array![];
    let mut j: usize = 1;
    let m = circuit_vertices.len();

    while j < m {
        let u = *circuit_vertices.at(j - 1);
        let v = *circuit_vertices.at(j);
        out.append((u, v));
        j += 1;
    };

    Option::Some(out)
}

/// Recursive Hierholzer: consume all edges out of `v`, then append `v` (post-order).
fn hierholzer(
    v: u8,
    verts: @Array<u8>,
    ref edges: Felt252Dict<u32>,
    ref circuit: Array<u8>,
) {
    loop {
        match find_neighbor(v, verts, ref edges) {
            Option::Some(u) => {
                dec_edge(v, u, ref edges);
                hierholzer(u, verts, ref edges, ref circuit);
            },
            Option::None => {
                break;
            },
        }
    };
    circuit.append(v);
}

/// Find any neighbor `u` among seen vertices with a remaining edge (v,u).
fn find_neighbor(
    v: u8,
    verts: @Array<u8>,
    ref edges: Felt252Dict<u32>,
) -> Option<u8> {
    let mut i: usize = 0;
    let len = verts.len();

    let result = loop {
        if i >= len {
            break Option::None;
        }

        let u = *verts.at(i);
        let (x, y) = norm_pair(v, u);
        let key = pack_pair(x, y);

        if edges.get(key) > 0_u32 {
            break Option::Some(u);
        }

        i += 1;
    };

    result
}

/// Decrement one copy of the undirected edge (a,b)
fn dec_edge(a: u8, b: u8, ref edges: Felt252Dict<u32>) {
    let (x, y) = norm_pair(a, b);
    let key = pack_pair(x, y);
    let cur = edges.get(key);
    edges.insert(key, cur - 1_u32);
}

/// All used vertices must have even degree.
fn all_even_degrees(
    verts: @Array<u8>,
    ref degree: Felt252Dict<u32>,
) -> bool {
    let mut i: usize = 0;
    let len = verts.len();

    let result = loop {
        if i >= len {
            break true;
        }

        let v = *verts.at(i);
        let d = degree.get(v.into());

        if (d % 2_u32) != 0_u32 {
            break false;
        }

        i += 1;
    };

    result
}

/// Connectivity among used vertices via BFS on remaining-edge presence.
fn is_connected(
    verts: @Array<u8>,
    ref edges: Felt252Dict<u32>,
) -> bool {
    if verts.len() == 0 {
        return true;
    }

    let start = *verts.at(0);

    let mut visited: Felt252Dict<bool> = Default::default();
    let mut q: Array<u8> = array![start];
    visited.insert(start.into(), true);

    let mut qi: usize = 0;
    while qi < q.len() {
        let v = *q.at(qi);
        qi += 1;

        let mut i: usize = 0;
        let n = verts.len();

        while i < n {
            let u = *verts.at(i);
            let (x, y) = norm_pair(v, u);
            let key = pack_pair(x, y);

            if edges.get(key) > 0_u32 && !visited.get(u.into()) {
                visited.insert(u.into(), true);
                q.append(u);
            }

            i += 1;
        }
    };

    let mut k: usize = 0;
    let n = verts.len();

    let all_visited = loop {
        if k >= n {
            break true;
        }

        let v = *verts.at(k);

        if !visited.get(v.into()) {
            break false;
        }

        k += 1;
    };

    all_visited
}

#[inline(always)]
fn norm_pair(a: u8, b: u8) -> (u8, u8) {
    if a <= b {
        (a, b)
    } else {
        (b, a)
    }
}

#[inline(always)]
fn pack_pair(x: u8, y: u8) -> felt252 {
    x.into() * 256 + y.into()
}