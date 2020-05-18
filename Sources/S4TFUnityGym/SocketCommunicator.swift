import Foundation
import Socket

final class SocketCommunicator {
    
    private let socket: Socket
    
    init(port: Int) throws {
        socket = try Socket.create()
        do {
            try socket.listen(on: port, maxBacklogSize: 0)
        } catch {
            socket.close()
            throw error
        }
    }
    
    func close() {
        guard socket.isActive else {
            return
        }
        let message = UnityMessage.with {
            $0.header = Header.with {
                $0.status = 400
            }
        }
        try? send(message)
        socket.close()
    }
    
    func exchange(input: UnityInput) throws -> UnityOutput {
        if socket.remoteConnectionClosed {
            throw SocketError.connectionClosed
        }
        let message = UnityMessage.with {
            $0.header = Header.with {
                $0.status = 200
            }
            $0.unityInput = input
        }
        try send(message)
        return try read().unityOutput
    }
    
    private func send(_ message: UnityMessage) throws {
        var data = try message.serializedData()
        var length = Int32(data.count)
        data.insert(contentsOf: Data(bytes: &length, count: 4), at: 0)
        try socket.write(from: data)
    }
    
    private func read() throws -> UnityMessage {
        var data = Data()
        guard var num = try? socket.read(into: &data), num > 4 else {
            throw SocketError.timeout
        }
        let len: Int32 = data[0...3].withUnsafeBytes { $0.load(as: Int32.self) } + 4
        while num != len {
            var d = Data()
            num += try socket.read(into: &d)
            data.append(d)
        }
        let message = try UnityMessage(serializedData: data.advanced(by: 4))
        if message.header.status != 200 {
            throw SocketError.message
        }
        return message
    }
    
    func initAcademyParams(seed: Int) throws -> UnityRLInitializationOutput {
        try socket.acceptConnection()
        try socket.setReadTimeout(value: 30000)
        let input = UnityInput.with {
            $0.rlInitializationInput = UnityRLInitializationInput.with {
                $0.seed = Int32(seed)
            }
        }
        return try exchange(input: input).rlInitializationOutput
    }
}
