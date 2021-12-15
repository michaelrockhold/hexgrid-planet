import Foundation
import simd

class Edge: Equatable {

    public static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.id == rhs.id
    }

    let id: Int
    var tiles: [Tile?]
    var corners: [Corner?]

    init(id: Int) {
        self.id = id
        self.tiles = [Tile?](repeating: nil, count: 2)
        self.corners = [Corner?](repeating: nil, count: 2)
    }

//int position (const Edge& e, const Tile* t) {
//	if (e.tiles[0] == t)
//		return 0;
//	else if (e.tiles[1] == t)
//		return 1;
//	return -1;
//}
//int position (const Edge& e, const Corner* c) {
//	if (e.corners[0] == c)
//		return 0;
//	else if (e.corners[1] == c)
//		return 1;
//	return -1;
//}
//
//int sign (const Edge& e, const Tile* t) {
//	if (e.tiles[0] == t)
//		return 1;
//	else if (e.tiles[1] == t)
//		return -1;
//	return 0;
//}
//int sign (const Edge& e, const Corner* c) {
//	if (e.corners[0] == c)
//		return 1;
//	else if (e.corners[1] == c)
//		return -1;
//	return 0;
//}
//
//const Tile* nth_tile (const Edge& e, int i) {
//	return e.tiles[i];
//}
//const Corner* nth_corner (const Edge& e, int i) {
//	return e.corners[i];
//}

}
