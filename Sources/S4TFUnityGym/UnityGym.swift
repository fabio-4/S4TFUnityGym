import TensorFlow

public final class UnityGym {
    
    public typealias StepInfo = (Tensor<Float>, Tensor<Float>, Tensor<Bool>, Tensor<Bool>)
    
    private let env: Environment
    private var state: BrainInfo
    private let brainName: String
    private let useVisual: Bool
    
    public let nAgents: Int
    public let numStackedObservations: Int
    public let actionSpace: ActionSpace
    public let observationSpace: ObservationSpace
    public var observation: Tensor<Float> {
        get {
            return useVisual ? state.visualObservation[0] : state.vectorObservation
        }
    }
    
    public init(_ path: String, workerId: Int = 0, useVisual: Bool = false) throws {
        env = try Environment(path: path, workerId: workerId, graphics: useVisual)
        guard let brainName = env.externalBrainNames.first,
            let brain = env.brains[brainName], env.brains.count == 1,
            !(useVisual && brain.numVisualObservations != 1) else {
                throw EnvironmentError.gym
        }
        self.brainName = brainName
        self.useVisual = useVisual
        self.numStackedObservations = useVisual ? brain.numVisualObservations : brain.numStackedVectorObservations
        
        state = try env.reset()[brainName]!
        nAgents = state.agents.count
        
        switch brain.vectorActionSpaceType {
        case .discrete:
            actionSpace = ActionSpace(
                    type: .discrete,
                    shape: brain.vectorActionSpaceSize,
                    values: brain.vectorActionSpaceSize.dimensions.map { (0.0, Float($0-1)) }
            )
        default:
            actionSpace = ActionSpace(
                    type: .continuous,
                    shape: brain.vectorActionSpaceSize,
                    values: Array<(Float, Float)>(
                        repeating: (-1.0, 1.0),
                        count: Int(brain.vectorActionSpaceSize.dimensions[0])
                    )
            )
        }
        
        if useVisual {
            observationSpace = ObservationSpace(brain.cameraResolutions[0], range: (0, 1))
        } else {
            observationSpace = ObservationSpace(brain.vectorObservationSpaceSize)
        }
    }
    
    public func close() {
        env.close()
    }
    
    @discardableResult
    public func reset() throws -> Tensor<Float> {
        state = try env.reset()[brainName]!
        if nAgents != state.agents.count { throw EnvironmentError.gym }
        return observation
    }
    
    public func step(_ actions: Tensor<Int32>) throws -> StepInfo {
        return try step(Tensor<Float>(actions))
    }
    
    public func step(_ actions: Tensor<Float>? = nil) throws -> StepInfo {
        if let actionCount = actions?.scalarCount, actionCount != nAgents * actionSpace.values.count {
            throw EnvironmentError.gym
        }
        let a = actions?.scalars ?? (0..<nAgents).flatMap { _ in actionSpace.sample() }
        state = try env.step(vectorAction: [brainName: a])[brainName]!
        if nAgents != state.agents.count { throw EnvironmentError.gym }
        return (observation, state.reward, state.localDone, state.maxReached)
    }
}
