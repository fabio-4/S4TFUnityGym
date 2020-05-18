import TensorFlow

struct BrainParameters {
    let brainName: String
    let vectorObservationSpaceSize: TensorShape
    let numStackedVectorObservations: Int
    let cameraResolutions: [TensorShape]
    let numVisualObservations: Int
    let vectorActionSpaceSize: TensorShape
    let vectorActionDescriptions: [String]
    let vectorActionSpaceType: SpaceTypeProto
    
    init(proto: BrainParametersProto) {
        brainName = proto.brainName
        vectorObservationSpaceSize = TensorShape(Int(proto.vectorObservationSize))
        numStackedVectorObservations = Int(proto.numStackedVectorObservations)
        cameraResolutions = proto.cameraResolutions.map {
            TensorShape([Int($0.height), Int($0.width), $0.grayScale ? 1 : 3])
        }
        numVisualObservations = cameraResolutions.count
        vectorActionSpaceSize = TensorShape(proto.vectorActionSize.map { Int($0) })
        vectorActionDescriptions = proto.vectorActionDescriptions
        vectorActionSpaceType = proto.vectorActionSpaceType
    }
}
