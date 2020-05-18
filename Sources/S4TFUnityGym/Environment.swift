import Foundation

final class Environment {
    
    private var proc: Process?
    private let comm: SocketCommunicator
    private let version = "API-8"
    private var nAgents = [String: Int]()
    private var globalDone: Bool?
    private(set) var brains = [String: BrainParameters]()
    private(set) var externalBrainNames = [String]()
    private let numExternalBrains: Int
    private var resetParameters: [String: Float]
    
    init(path: String? = nil, workerId: Int = 0, basePort: Int = 5005, seed: Int = 0,
        graphics: Bool = true) throws {
        comm = try SocketCommunicator(port: basePort + workerId)
        var acaParams: UnityRLInitializationOutput!
        do {
            if let path = path {
                proc = Environment.createTask(path, basePort + workerId, graphics)
                try proc!.run()
            } else if workerId != 0 || basePort != 5005 {
                throw EnvironmentError.editorConnection
            }
            
            acaParams = try comm.initAcademyParams(seed: seed)
            resetParameters = acaParams.environmentParameters.floatParameters
            
            //empty exchange, unity env: one reset command needed to start iteration
            _ = try comm.exchange(input: Environment.generateResetInput(config: resetParameters, training: true))
            if acaParams.version != version {
                throw EnvironmentError.protoVersion
            }
        } catch {
            Environment.close(comm: comm, proc: proc)
            throw error
        }
        for brainParam in acaParams.brainParameters {
            brains[brainParam.brainName] = BrainParameters(proto: brainParam)
            if brainParam.isTraining {
                externalBrainNames.append(brainParam.brainName)
            }
        }
        numExternalBrains = externalBrainNames.count
    }
    
    deinit {
        close()
    }
    
    private class func createTask(_ path: String, _ port: Int, _ graphics: Bool) -> Process {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        task.arguments = [path, "--args", "--port", String(port)]
        if !graphics {
            task.arguments! += ["-nographics", "-batchmode"]
        }
        return task
    }
    
    private class func close(comm: SocketCommunicator, proc: Process?) {
        comm.close()
        if let proc = proc, proc.isRunning {
            proc.terminate()
        }
    }
    
    func close() {
        Environment.close(comm: comm, proc: proc)
    }
    
    private func getState(_ output: UnityRLOutput) -> [String: BrainInfo] {
        var data = [String: BrainInfo]()
        for (name, info) in output.agentInfos {
            guard let brainParams = brains[name] else { continue }
            data[name] = BrainInfo(agentInfoList: info.value, brainParams: brainParams)
        }
        return data
    }
    
    private func takeStep(_ input: UnityInput) throws -> [String: BrainInfo] {
        let outputs = try comm.exchange(input: input)
        let state = getState(outputs.rlOutput)
        globalDone = outputs.rlOutput.globalDone
        for b in externalBrainNames {
            nAgents[b] = state[b]?.agents.count ?? 0
        }
        return state
    }
    
    func reset(config: [String: Float]? = nil, trainMode: Bool = true) throws -> [String: BrainInfo] {
        if let config = config {
            for (k, v) in config {
                if resetParameters.keys.contains(k) {
                    resetParameters[k] = v
                } else {
                    throw EnvironmentError.invalidParam
                }
            }
        }
        let resetInput = Environment.generateResetInput(config: config ?? self.resetParameters, training: trainMode)
        return try takeStep(resetInput)
    }
    
    private class func generateResetInput(config: [String: Float], training: Bool) -> UnityInput {
        let rlIn = UnityRLInput.with {
            $0.isTraining = training
            $0.command = CommandProto.reset
            $0.environmentParameters = EnvironmentParametersProto.with {
                $0.floatParameters = config
            }
        }
        return Environment.wrapUnityInput(rlInput: rlIn)
    }
    
    func step(vectorAction: [String: [Float]]) throws -> [String: BrainInfo] {
        var vAct = [String: [Float]]()
        guard let globalDone = globalDone, !globalDone, externalBrainNames.containsKeys(dicts: vectorAction) else {
            throw EnvironmentError.action
        }
        for brainName in externalBrainNames {
            let nAgent = nAgents[brainName]!
            let discrete = brains[brainName]!.vectorActionSpaceType == .discrete
            let size = nAgent * (discrete ? brains[brainName]!.vectorActionSpaceSize.count : brains[brainName]!.vectorActionSpaceSize[0])
            
            if let action = vectorAction[brainName] {
                if action.count == size {
                    vAct[brainName] = action
                } else {
                    throw EnvironmentError.action
                }
            } else {
                vAct[brainName] = Array<Float>(repeating: 0, count: size)
            }
        }
        let stepInput = generateStepInput(vectorAction: vAct)
        return try takeStep(stepInput)
    }
    
    private func generateStepInput(vectorAction: [String: [Float]]) -> UnityInput {
        var rlIn = UnityRLInput()
        rlIn.command = CommandProto.step
        for (b, v) in vectorAction {
            guard let nAgents = self.nAgents[b], nAgents > 0 else {
                continue
            }
            var agentActionProtoList = UnityRLInput.ListAgentActionProto()
            let aNum = v.count / nAgents
            for i in 0..<nAgents {
                let action = AgentActionProto.with {
                    $0.vectorActions = Array(v[i*aNum..<(i+1)*aNum])
                }
                agentActionProtoList.value.append(action)
            }
            rlIn.agentActions[b] = agentActionProtoList
        }
        return Environment.wrapUnityInput(rlInput: rlIn)
    }
    
    private class func wrapUnityInput(rlInput: UnityRLInput) -> UnityInput {
        return UnityInput.with {
            $0.rlInput = rlInput
        }
    }
}
