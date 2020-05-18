import TensorFlow

public struct ObservationSpace {
    public let shape: TensorShape
    public let range: (Float, Float)
    
    init(_ shape: TensorShape, range: (Float, Float) = (Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude)) {
        self.shape = shape
        self.range = range
    }
}

public struct ActionSpace {
    public enum ActionType {
        case discrete, continuous
    }
    
    public let type: ActionType
    public let shape: TensorShape
    public let values: [(Float, Float)]
    
    func sample() -> [Float] {
        switch type {
        case .discrete:
            return values.map { round(Float.random(in: $0.0...$0.1)) }
        case .continuous:
            return values.map { Float.random(in: $0.0...$0.1) }
        }
    }
    
    public func sample(squeezingShape: Bool = true) -> Tensor<Int32> {
        let samples = Tensor<Int32>(values.map { Int32.random(in: Int32($0.0)...Int32($0.1)) })
        return squeezingShape ? samples.squeezingShape(at: []) : samples
    }
    
    public func sample(squeezingShape: Bool = true) -> Tensor<Float> {
        let samples = Tensor<Float>(sample())
        return squeezingShape ? samples.squeezingShape(at: []) : samples
    }
}
