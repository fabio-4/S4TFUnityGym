import Foundation
import TensorFlow

struct BrainInfo {
    let agents: [Int]
    let visualObservation: [Tensor<Float>]
    let vectorObservation: Tensor<Float>
    let reward: Tensor<Float>
    let localDone: Tensor<Bool>
    let maxReached: Tensor<Bool>
    
    init(agentInfoList: [AgentInfoProto], brainParams: BrainParameters) {
        agents = agentInfoList.map { Int($0.id) }
        visualObservation = (0..<brainParams.numVisualObservations).map { (i: Int) -> Tensor<Float> in
            let data = agentInfoList.map {
                BrainInfo.processPixels(bytes: $0.visualObservations[i], resolution: brainParams.cameraResolutions[i])
            }
            return Tensor<Float>(data)
        }
        vectorObservation = Tensor<Float>(agentInfoList.map { Tensor<Float>($0.stackedVectorObservation.nanToNum()) })
        reward = Tensor<Float>(agentInfoList.map { !$0.reward.isNaN ? $0.reward : Float.zero })
        localDone = Tensor<Bool>(agentInfoList.map { $0.done })
        maxReached = Tensor<Bool>(agentInfoList.map { $0.maxStepReached })
    }
    
    static func processPixels(bytes: Data, resolution: TensorShape) -> Tensor<Float> {
        let str = StringTensor(bytes.base64EncodedString().base64Safe())
        let img = _Raw.decodeBase64(str)
        let decoded: Tensor<UInt8> = _Raw.decodePng(contents: img, channels: Int64(resolution.dimensions[2]))
        return Tensor<Float>(decoded) / Float(255.0)
    }
}

extension String {
    //copied, can't find the source, seems to be working
    func base64Safe() -> String {
        self.replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_")
    }
}
