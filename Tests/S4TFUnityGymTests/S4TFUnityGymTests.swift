import XCTest
import TensorFlow
@testable import S4TFUnityGym

final class S4TFUnityGymTests: XCTestCase {
    
    func testEnvVect() {
        let path = "/...PATHTO/Basic.app"
        if let env = try? UnityGym(path) {
            XCTAssertEqual(env.actionSpace.shape[0], 3)
            XCTAssertEqual(env.numStackedObservations, 1)
            XCTAssertEqual(env.observationSpace.shape.contiguousSize, 20)
            XCTAssertEqual(env.nAgents, 1)
            do {
                let (o1, r, d, m) = try env.step()
                XCTAssertEqual(o1.shape.dimensions, [1, 20])
                XCTAssertEqual(r.shape.dimensions, [1])
                XCTAssertEqual(d.shape.dimensions, [1])
                XCTAssertEqual(m.shape.dimensions, [1])
                let o2 = try env.reset()
                XCTAssertEqual(o2.shape.dimensions, [1, 20])
            } catch {
                print(error)
            }
            env.close()
        }
    }
    
    func testEnvVisual() {
        let path = "/...PATHTO/GridWorld.app"
        if let env = try? UnityGym(path, useVisual: true) {
            XCTAssertEqual(env.actionSpace.shape[0], 5)
            XCTAssertEqual(env.numStackedObservations, 1)
            XCTAssertEqual(env.observationSpace.shape.contiguousSize, 21168)
            XCTAssertEqual(env.nAgents, 1)
            do {
                let (o1, r, d, m) = try env.step()
                XCTAssertEqual(o1.shape.dimensions, [1, 84, 84, 3])
                XCTAssertEqual(r.shape.dimensions, [1])
                XCTAssertEqual(d.shape.dimensions, [1])
                XCTAssertEqual(m.shape.dimensions, [1])
                let o2 = try env.reset()
                XCTAssertEqual(o2.shape.dimensions, [1, 84, 84, 3])
            } catch {
                print(error)
            }
            env.close()
        }
    }

    static var allTests = [
        ("testEnvVect", testEnvVect),
        ("testEnvVisual", testEnvVisual),
    ]
}
