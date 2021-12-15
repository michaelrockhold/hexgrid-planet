import Foundation
import simd

public class HexGridPlanet {
    
    private var grid: Grid
    private var terrain: Terrain
    private var climate: Climate
    
    public var size: Int {
        return grid.tiles.count
    }
    
    public init(_ sz: Int) {
        grid = HexGridPlanet.size_n_grid(sz)
        terrain = Terrain()
        climate = Climate()
    }
    
    private static func size_n_grid(_ size: Int) -> Grid {
        if size == 0 {
            return size_0_grid()
        }
        else {
            return subdivided_grid(prev: size_n_grid(size-1))
        }
    }
    
    private static func size_0_grid() -> Grid {
        
        let grid = Grid(s: 0)
        let x = -0.525731112119133606
        let z = -0.850650808352039932
        
        let icos_tiles = [
            simd_double3(-x, 0, z),
            simd_double3(x, 0, z),
            simd_double3(-x, 0, -z),
            simd_double3(x, 0, -z),
            simd_double3(0, z, x),
            simd_double3(0, z, -x),
            simd_double3(0, -z, x),
            simd_double3(0, -z, -x),
            simd_double3(z, x, 0),
            simd_double3(-z, x, 0),
            simd_double3(z, -x, 0),
            simd_double3(-z, -x, 0)
        ]
        
        let icos_tiles_n = [
            [9, 4, 1, 6, 11],
            [4, 8, 10, 6, 0],
            [11, 7, 3, 5, 9],
            [2, 7, 10, 8, 5],
            [9, 5, 8, 1, 0],
            [2, 3, 8, 4, 9],
            [0, 1, 10, 7, 11],
            [11, 6, 10, 3, 2],
            [5, 3, 10, 1, 4],
            [2, 5, 4, 0, 11],
            [3, 7, 6, 1, 8],
            [7, 2, 9, 0, 6]
        ]
        
        for t in grid.tiles {
            t.v = icos_tiles[t.id]
            for k in 0..<5 {
                t.tiles[k] = grid.tiles[icos_tiles_n[t.id][k]]
            }
        }
        for i in 0..<5 {
            grid.addCorner(id: i,
                           t: (0, icos_tiles_n[0][(i+4)%5], icos_tiles_n[0][i]))
        }
        for i in 0..<5 {
            grid.addCorner(id: i+5,
                           t: (3, icos_tiles_n[3][(i+4)%5], icos_tiles_n[3][i]))
        }
        grid.addCorner(id: 10, t: (10,1,8))
        grid.addCorner(id: 11, t: (1,10,6))
        grid.addCorner(id: 12, t: (6,10,7))
        grid.addCorner(id: 13, t: (6,7,11))
        grid.addCorner(id: 14, t: (11,7,2))
        grid.addCorner(id: 15, t: (11,2,9))
        grid.addCorner(id: 16, t: (9,2,5))
        grid.addCorner(id: 17, t: (9,5,4))
        grid.addCorner(id: 18, t: (4,5,8))
        grid.addCorner(id: 19, t: (4,8,1))
        
        //_add corners to corners
        for c in grid.corners {
            for k in 0..<3 {
                c.corners[k] = c.tiles[k]!.corners[(c.tiles[k]!.position(c)!+1)%5]
            }
        }
        //new edges
        var next_edge_id = 0
        for t in grid.tiles {
            for k in 0..<5 {
                if t.edges[k] == nil {
                    grid.addEdge(id: next_edge_id, t: (t.id, icos_tiles_n[t.id][k]))
                    next_edge_id += 1
                }
            }
        }
        return grid
    }
    
    private static func subdivided_grid(prev: Grid) -> Grid {
        
        let grid = Grid(s: prev.size + 1)
        
        let prev_tile_count = prev.tiles.count
        let prev_corner_count = prev.corners.count
                
        //old tiles
        for i in 0..<prev_tile_count {
            grid.tiles[i].v = prev.tiles[i].v
            for k in 0..<grid.tiles[i].edge_count {
                grid.tiles[i].tiles[k] = grid.tiles[prev.tiles[i].corners[k]!.id+prev_tile_count]
            }
        }
        //old corners become tiles
        for i in 0..<prev_corner_count {
            grid.tiles[i+prev_tile_count].v = prev.corners[i].v
            for k in 0..<3 {
                grid.tiles[i+prev_tile_count].tiles[2*k] = grid.tiles[prev.corners[i].corners[k]!.id+prev_tile_count]
                grid.tiles[i+prev_tile_count].tiles[2*k+1] = grid.tiles[prev.corners[i].tiles[k]!.id]
            }
        }
        //new corners
        var next_corner_id = 0
        for n in prev.tiles {
            let t = grid.tiles[n.id]
            for k in 0..<t.edge_count {
                grid.addCorner(id: next_corner_id,
                               t: (t.id, t.tiles[(k+t.edge_count-1)%t.edge_count]!.id, t.tiles[k]!.id))
                next_corner_id += 1
            }
        }
        //connect corners
        for c in grid.corners {
            for k in 0..<3 {
                c.corners[k] = c.tiles[k]!.corners[(c.tiles[k]!.position(c)!+1)%(c.tiles[k]!.edge_count)]
            }
        }
        //new edges
        var next_edge_id = 0
        for t in grid.tiles {
            for k in 0..<t.edge_count {
                if t.edges[k] == nil {
                    grid.addEdge(id: next_edge_id, t: (t.id, t.tiles[k]!.id))
                    next_edge_id += 1
                }
            }
        }
        
        print("Grid size n == \(grid.size), tiles: \(grid.tiles.count), corners: \(grid.corners.count), edges: \(grid.edges.count)")

        return grid
    }
}
