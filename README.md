# Swift for TensorFlow ...for Unity ML-Agents (Gym)

Minimal Swift-Client for [Unity ML-Agents](https://github.com/Unity-Technologies/ml-agents)  
(old and outdated)

Required:
* [Unity ML-Agents 0.8.0](https://github.com/Unity-Technologies/ml-agents/releases)
* [S4TF Release 0.8.0](https://github.com/tensorflow/swift)
* Only working with [Environment Executables](https://github.com/Unity-Technologies/ml-agents/blob/master/docs/Learning-Environment-Executable.md)
* MacOS Version 10.13+; using [Swift-Protobuf](https://github.com/apple/swift-protobuf) and [BlueSocket](https://github.com/IBM-Swift/BlueSocket)

## [Examples](https://github.com/fabio-4/S4TFRL)
* DQN
* PPO
* UDRL

## Setup (Unity-Env)
* Academy.cs using SocketCommunicator.cs instead of RpcCommunicator.cs (L292 & L307):
```csharp
communicator = new RPCCommunicator(...);
// =>
communicator = new SocketCommunicator(...);
```
* SocketCommunicator (L15): Environment timeout value

## API
* Create/close environment:
```swift
let path = "/...PATHTO/Env.app"
guard let env = try? UnityGym(path) else {
    exit(0)
}
defer { env.close() }
```
* Environment Data:
```swift
let actionDims = env.actionSpace.shape
// Cont. actionSpace:
let actionDim = actionDims[0]
// (Multi)-Disc. actionSpace:
let actionDim0 = actionDims[0]
let actionDim1 = actionDims[1]
...
let nO = env.numStackedObservations
let inputLen = env.observationSpace.shape.contiguousSize * nO
let n = env.nAgents
```
* Environment Interaction:
```swift
let obs = env.observation
let obs = try env.reset()
let (obs, reward, done, maxStepReached) = try env.step(action)

step(Tensor<Int32> / Tensor<Float>? = nil)
// TensorShape: (nAgents, actionDim), 
// nil/ opt. => Random action

/* 
obs: Tensor<Float>, TensorShape: (nAgents, observationSpace)
reward: Tensor<Float>, TensorShape: (nAgents)
done: Tensor<Bool>, TensorShape: (nAgents)
maxStepReached: Tensor<Bool>, TensorShape: (nAgents) 
*/
```
```swift
do {
    var o1 = try env.reset()
    let a = model(o1)
    let (o2, r, d, m) = try env.step(a)
} catch {
    print(error)
}
```
