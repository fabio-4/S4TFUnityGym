enum EnvironmentError: Error {
    case editorConnection
    case protoVersion
    case invalidParam
    case action
    case gym
}

enum SocketError: Error {
    case connection
    case connectionClosed
    case message
    case timeout
}
