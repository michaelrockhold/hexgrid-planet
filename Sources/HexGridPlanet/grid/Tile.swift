import Foundation
import simd

public class Tile: Equatable {
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let edge_count: Int
    var v: simd_double3? = nil
    var tiles: [Tile?]
    var corners: [Corner?]
    var edges: [Edge?]
    
    init(id: Int, edge_count: Int) {
        
        self.id = id
        self.edge_count = edge_count

        tiles = [Tile?](repeating: nil, count: edge_count)
        corners = [Corner?](repeating: nil, count: edge_count)
        edges = [Edge?](repeating: nil, count: edge_count)
    }
    
    func position(_ c: Corner) -> Int? {
        for i in 0..<edge_count {
            if corners[i] == c {
                return i
            }
        }
        return nil
    }
    
    func position(_ n: Tile) -> Int? {
        for i in 0..<edge_count {
            if tiles[i] == n {
                return i
            }
        }
        return nil
    }

}

//
//int id (const Tile&);
//int edge_count (const Tile&);
//const Vector3& vector (const Tile&);
//const std::vector<const Tile*>& tiles (const Tile&);
//const std::vector<const Corner*>& corners (const Tile&);
//const std::vector<const Edge*>& edges (const Tile&);
//const Tile* nth_tile (const Tile&, int);
//const Corner* nth_corner (const Tile&, int);
//const Edge* nth_edge (const Tile&, int);
//
//int position (const Tile&, const Tile*);
//int position (const Tile&, const Corner*);
//int position (const Tile&, const Edge*);
//
//Quaternion reference_rotation (const Tile*, Quaternion);
//std::vector<Vector2> polygon (const Tile*, Quaternion);
//
//inline int id (const Tile* t) {return id(*t);}
//inline int edge_count (const Tile* t) {return edge_count(*t);}
//inline const Vector3& vector (const Tile* t) {return vector(*t);}
//inline const std::vector<const Tile*>& tiles (const Tile* t) {return tiles(*t);}
//inline const std::vector<const Corner*>& corners (const Tile* t) {return corners(*t);}
//inline const std::vector<const Edge*>& edges (const Tile* t) {return edges(*t);}
//inline const Tile* nth_tile (const Tile* t, int n) {return nth_tile(*t, n);}
//inline const Corner* nth_corner (const Tile* t, int n) {return nth_corner(*t, n);}
//inline const Edge* nth_edge (const Tile* t, int n) {return nth_edge(*t, n);}
//
//inline int position (const Tile* t, const Tile* n) {return position(*t, n);}
//inline int position (const Tile* t, const Corner* c) {return position(*t, c);}
//inline int position (const Tile* t, const Edge* e) {return position(*t, e);}


//
//
//int position (const Tile& t, const Edge* e) {
//	for (int i=0; i<t.edge_count; i++)
//		if (t.edges[i] == e)
//			return i;
//	return -1;
//}
//
//int id (const Tile& t) {return t.id;}
//int edge_count (const Tile& t) {return t.edge_count;}
//const Vector3& vector (const Tile& t) {return t.v;}
//const std::vector<const Tile*>& tiles (const Tile& t) {return t.tiles;}
//const std::vector<const Corner*>& corners (const Tile& t) {return t.corners;}
//const std::vector<const Edge*>& edges (const Tile& t) {return t.edges;}
//
//const Tile* nth_tile (const Tile& t, int n) {
//	int k = n < 0 ?
//		n % edge_count(t) + edge_count(t) :
//		n % edge_count(t);
//	return t.tiles[k];
//}
//
//const Corner* nth_corner (const Tile& t, int n) {
//	int k = n < 0 ?
//		n % edge_count(t) + edge_count(t) :
//		n % edge_count(t);
//	return t.corners[k];
//}
//
//const Edge* nth_edge (const Tile& t, int n) {
//	int k = n < 0 ?
//		n % edge_count(t) + edge_count(t) :
//		n % edge_count(t);
//	return t.edges[k];
//}
//
//Quaternion reference_rotation (const Tile* t, Quaternion d) {
//	Vector3 v = d * vector(t);
//	Quaternion h = Quaternion();
//	if (v.x != 0 || v.y != 0) {
//		if (v.y != 0) h = Quaternion(normal(Vector3(v.x, v.y, 0)), Vector3(-1,0,0));
//		else if (v.x > 0) h = Quaternion(Vector3(0,0,1), pi);
//	}
//	Quaternion q = Quaternion();
//	if (v.x == 0 && v.y == 0) {
//		if (v.z < 0) q = Quaternion(Vector3(1,0,0), pi);
//	}
//	else {
//		q = Quaternion(h*v, Vector3(0,0,1));
//	}
//	return q*h*d;
//}
//
//std::vector<Vector2> polygon (const Tile* t, Quaternion d) {
//	std::vector<Vector2> p;
//	Quaternion q = reference_rotation(t, d);
//	for (int i=0; i<edge_count(t); i++) {
//		Vector3 c = q * vector(nth_corner(t, i));
//		p.push_back(Vector2(c.x, c.y));
//	}
//	return p;
//}
