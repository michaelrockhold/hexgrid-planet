import Foundation
import simd

class Corner: Equatable {
    static func == (lhs: Corner, rhs: Corner) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    var tiles = [Tile?](repeating: nil, count: 3)
    var corners = [Corner?](repeating: nil, count: 3)
    var edges = [Edge?](repeating: nil, count: 3)
    var v: simd_double3? = nil

    init(_ i: Int) {
        id = i
    }

    //int position (const Corner& c, const Tile* t) {
    //    for (int i=0; i<3; i++)
    //        if (c.tiles[i] == t)
    //            return i;
    //    return -1;
    //}
    func position(_ n: Corner) -> Int? {
        for i in 0..<3 {
            if corners[i] == n {
                return i
            }
        }
        return nil
    }
    //int position (const Corner& c, const Edge* e) {
    //    for (int i=0; i<3; i++)
    //        if (c.edges[i] == e)
    //            return i;
    //    return -1;
    //}

//const Vector3& vector (const Corner&);
//const std::array<const Tile*, 3>& tiles (const Corner&);
//const std::array<const Corner*, 3>& corners (const Corner&);
//const std::array<const Edge*, 3>& edges (const Corner&);
//const Corner* nth_corner (const Corner&, int);
//const Edge* nth_edge (const Corner&, int);
//
//int position (const Corner&, const Tile*);
//int position (const Corner&, const Corner*);
//int position (const Corner&, const Edge*);
//
//inline int id (const Corner* c) {return id(*c);}
//inline const Vector3& vector (const Corner* c) {return vector(*c);}
//inline const std::array<const Tile*, 3>& tiles (const Corner* c) {return tiles(*c);}
//inline const std::array<const Corner*, 3>& corners (const Corner* c) {return corners(*c);}
//inline const std::array<const Edge*, 3>& edges (const Corner* c) {return edges(*c);}
//inline const Corner* nth_corner (const Corner* c, int i) {return nth_corner(*c, i);}
//inline const Edge* nth_edge (const Corner* c, int i) {return nth_edge(*c, i);}
//
//inline int position (const Corner* c, const Tile* t) {return position(*c, t);}
//inline int position (const Corner* c, const Corner* n) {return position(*c, n);}
//inline int position (const Corner* c, const Edge* e) {return position(*c, e);}
//
//
//int id (const Corner& c) {return c.id;}
//const Vector3& vector (const Corner& c) {return c.v;}
//const std::array<const Tile*, 3>& tiles (const Corner& c) {return c.tiles;}
//const std::array<const Corner*, 3>& corners (const Corner& c) {return c.corners;}
//const std::array<const Edge*, 3>& edges (const Corner& c) {return c.edges;}
//
//const Corner* nth_corner (const Corner& c, int i) {
//	int k = i < 0 ?
//		i%3 + 3 :
//		i%3;
//	return c.corners[k];
//}
//const Edge* nth_edge (const Corner& c, int i) {
//	int k = i < 0 ?
//		i%3 + 3 :
//		i%3;
//	return c.edges[k];
//}
}
