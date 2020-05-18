// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: mlagents/envs/communicator_objects/unity_message.proto
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

struct UnityMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var header: Header {
    get {return _storage._header ?? Header()}
    set {_uniqueStorage()._header = newValue}
  }
  /// Returns true if `header` has been explicitly set.
  var hasHeader: Bool {return _storage._header != nil}
  /// Clears the value of `header`. Subsequent reads from it will return its default value.
  mutating func clearHeader() {_uniqueStorage()._header = nil}

  var unityOutput: UnityOutput {
    get {return _storage._unityOutput ?? UnityOutput()}
    set {_uniqueStorage()._unityOutput = newValue}
  }
  /// Returns true if `unityOutput` has been explicitly set.
  var hasUnityOutput: Bool {return _storage._unityOutput != nil}
  /// Clears the value of `unityOutput`. Subsequent reads from it will return its default value.
  mutating func clearUnityOutput() {_uniqueStorage()._unityOutput = nil}

  var unityInput: UnityInput {
    get {return _storage._unityInput ?? UnityInput()}
    set {_uniqueStorage()._unityInput = newValue}
  }
  /// Returns true if `unityInput` has been explicitly set.
  var hasUnityInput: Bool {return _storage._unityInput != nil}
  /// Clears the value of `unityInput`. Subsequent reads from it will return its default value.
  mutating func clearUnityInput() {_uniqueStorage()._unityInput = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "communicator_objects"

extension UnityMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UnityMessage"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "header"),
    2: .standard(proto: "unity_output"),
    3: .standard(proto: "unity_input"),
  ]

  fileprivate class _StorageClass {
    var _header: Header? = nil
    var _unityOutput: UnityOutput? = nil
    var _unityInput: UnityInput? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _header = source._header
      _unityOutput = source._unityOutput
      _unityInput = source._unityInput
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
        case 1: try decoder.decodeSingularMessageField(value: &_storage._header)
        case 2: try decoder.decodeSingularMessageField(value: &_storage._unityOutput)
        case 3: try decoder.decodeSingularMessageField(value: &_storage._unityInput)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._header {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._unityOutput {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._unityInput {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UnityMessage, rhs: UnityMessage) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._header != rhs_storage._header {return false}
        if _storage._unityOutput != rhs_storage._unityOutput {return false}
        if _storage._unityInput != rhs_storage._unityInput {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
