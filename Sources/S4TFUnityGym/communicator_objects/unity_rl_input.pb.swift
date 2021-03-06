// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: mlagents/envs/communicator_objects/unity_rl_input.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct UnityRLInput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var agentActions: Dictionary<String,UnityRLInput.ListAgentActionProto> {
    get {return _storage._agentActions}
    set {_uniqueStorage()._agentActions = newValue}
  }

  var environmentParameters: EnvironmentParametersProto {
    get {return _storage._environmentParameters ?? EnvironmentParametersProto()}
    set {_uniqueStorage()._environmentParameters = newValue}
  }
  /// Returns true if `environmentParameters` has been explicitly set.
  var hasEnvironmentParameters: Bool {return _storage._environmentParameters != nil}
  /// Clears the value of `environmentParameters`. Subsequent reads from it will return its default value.
  mutating func clearEnvironmentParameters() {_uniqueStorage()._environmentParameters = nil}

  var isTraining: Bool {
    get {return _storage._isTraining}
    set {_uniqueStorage()._isTraining = newValue}
  }

  var command: CommandProto {
    get {return _storage._command}
    set {_uniqueStorage()._command = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  struct ListAgentActionProto {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    var value: [AgentActionProto] = []

    var unknownFields = SwiftProtobuf.UnknownStorage()

    init() {}
  }

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "communicator_objects"

extension UnityRLInput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UnityRLInput"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "agent_actions"),
    2: .standard(proto: "environment_parameters"),
    3: .standard(proto: "is_training"),
    4: .same(proto: "command"),
  ]

  fileprivate class _StorageClass {
    var _agentActions: Dictionary<String,UnityRLInput.ListAgentActionProto> = [:]
    var _environmentParameters: EnvironmentParametersProto? = nil
    var _isTraining: Bool = false
    var _command: CommandProto = .step

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _agentActions = source._agentActions
      _environmentParameters = source._environmentParameters
      _isTraining = source._isTraining
      _command = source._command
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,UnityRLInput.ListAgentActionProto>.self, value: &_storage._agentActions)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._environmentParameters)
        case 3: try decoder.decodeSingularBoolField(value: &_storage._isTraining)
        case 4: try decoder.decodeSingularEnumField(value: &_storage._command)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._agentActions.isEmpty {
        try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufString,UnityRLInput.ListAgentActionProto>.self, value: _storage._agentActions, fieldNumber: 1)
      }
      if let v = _storage._environmentParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if _storage._isTraining != false {
        try visitor.visitSingularBoolField(value: _storage._isTraining, fieldNumber: 3)
      }
      if _storage._command != .step {
        try visitor.visitSingularEnumField(value: _storage._command, fieldNumber: 4)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UnityRLInput, rhs: UnityRLInput) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._agentActions != rhs_storage._agentActions {return false}
        if _storage._environmentParameters != rhs_storage._environmentParameters {return false}
        if _storage._isTraining != rhs_storage._isTraining {return false}
        if _storage._command != rhs_storage._command {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension UnityRLInput.ListAgentActionProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = UnityRLInput.protoMessageName + ".ListAgentActionProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.value)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UnityRLInput.ListAgentActionProto, rhs: UnityRLInput.ListAgentActionProto) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
