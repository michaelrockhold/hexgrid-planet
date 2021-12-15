//
//  File.swift
//  
//
//  Created by Michael Rockhold on 12/12/21.
//

import Foundation
import Collections
import simd

public class Grid {
    
    let size: Int

    let tiles: Deque<Tile>
    let corners: Deque<Corner>
    let edges: Deque<Edge>
    
    private static func build(_ s: Int) -> (Deque<Tile>, Deque<Corner>, Deque<Edge>) {
        
        func tile_count (_ size: Int) -> Int {
            return 10*Int(pow(Double(3), Double(size)))+2
        }
        func corner_count(_ size: Int) -> Int {
            return 20*Int(pow(Double(3), Double(size)))
        }
        func edge_count(_ size: Int) -> Int {
            return 30*Int(pow(Double(3), Double(size)))
        }

        let tileCount = tile_count(s)
        var tiles = Deque<Tile>(minimumCapacity: tileCount)
        for i in 0..<tileCount {
            tiles.append(Tile(id: i, edge_count: i<12 ? 5 : 6))
        }
        
        let cornerCount = corner_count(s)
        var corners = Deque<Corner>(minimumCapacity: cornerCount)
        for i in 0..<cornerCount {
            corners.append(Corner(i))
        }
        
        let edgeCount = edge_count(s)
        var edges = Deque<Edge>(minimumCapacity: edgeCount)
        for i in 0..<edgeCount {
            edges.append(Edge(id: i))
        }
        return (tiles, corners, edges)
    }
    
    init(s: Int) {
        size = s
        (tiles, corners, edges) = Grid.build(s)
    }

//    const Tile* nth_tile (const Planet& p, int n) {return &p.grid->tiles[n];}
//    const Corner* nth_corner (const Planet& p, int n) {return &p.grid->corners[n];}
//    const Edge* nth_edge (const Planet& p, int n) {return &p.grid->edges[n];}
//
//    int tile_count (const Planet& p) {return p.grid->tiles.size();}
//    int corner_count (const Planet& p) {return p.grid->corners.size();}
//    int edge_count (const Planet& p) {return p.grid->edges.size();}
//

}

extension Grid {
    
    func addCorner(id: Int, t: (Int, Int, Int)) {
        let c = self.corners[id]
        let ti = [self.tiles[t.0], self.tiles[t.1], self.tiles[t.2]]
        let v: simd_double3 = ti[0].v! + ti[1].v! + ti[2].v!
        
        c.v = simd_normalize(v)
        for i in 0..<3 {
            ti[i].corners[ti[i].position(ti[(i+2)%3])!] = c
            c.tiles[i] = ti[i]
        }
    }
    
    func addEdge(id: Int, t: (Int, Int)) {
        let e = edges[id]
        let ti = [tiles[t.0], tiles[t.1]]
        let c = [
            corners[ti[0].corners[ti[0].position(ti[1])!]!.id],
            corners[ti[0].corners[(ti[0].position(ti[1])!+1)%ti[0].edge_count]!.id]
        ]
        
        for i in 0..<2 {
            ti[i].edges[ti[i].position(ti[(i+1)%2])!] = e
            e.tiles[i] = ti[i]
            c[i].edges[c[i].position(c[(i+1)%2])!] = e
            e.corners[i] = c[i]
        }
    }
}
