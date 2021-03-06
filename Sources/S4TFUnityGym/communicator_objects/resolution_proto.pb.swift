// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: mlagents/envs/communicator_objects/resolution_proto.proto
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

struct ResolutionProto {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var width: Int32 = 0

  var height: Int32 = 0

  var grayScale: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "communicator_objects"

extension ResolutionProto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ResolutionProto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "width"),
    2: .same(proto: "height"),
    3: .standard(proto: "gray_scale"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.width)
      case 2: try decoder.decodeSingularInt32Field(value: &self.height)
      case 3: try decoder.decodeSingularBoolField(value: &self.grayScale)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.width != 0 {
      try visitor.visitSingularInt32Field(value: self.width, fieldNumber: 1)
    }
    if self.height != 0 {
      try visitor.visitSingularInt32Field(value: self.height, fieldNumber: 2)
    }
    if self.grayScale != false {
      try visitor.visitSingularBoolField(value: self.grayScale, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: ResolutionProto, rhs: ResolutionProto) -> Bool {
    if lhs.width != rhs.width {return false}
    if lhs.height != rhs.height {return false}
    if lhs.grayScale != rhs.grayScale {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
