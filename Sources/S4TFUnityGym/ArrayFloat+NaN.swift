import Foundation

extension Array where Iterator.Element == Float {
    func nanToNum() -> Array<Float> {
        var copy = self
        for i in self.indices {
            if self[i].isNaN {
                copy[i] = 0
            } else if self[i].isInfinite {
                copy[i] = copy[i] > 0 ? Float.greatestFiniteMagnitude : -Float.greatestFiniteMagnitude
            }
        }
        return copy
    }
}
