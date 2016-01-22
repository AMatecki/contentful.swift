//
//  ContentfulTests.swift
//  ContentfulTests
//
//  Created by Boris Bügling on 18/08/15.
//  Copyright © 2015 Contentful GmbH. All rights reserved.
//

import CryptoSwift
import Interstellar
import Nimble
import Quick

import Contentful

class ContentfulBaseTests: QuickSpec {
    var client: Client!

    override func spec() {
        beforeEach {
            self.client = Client(spaceIdentifier: "cfexampleapi", accessToken: "b4c0n73n7fu1")
        }
    }
}

class ContentfulTests: ContentfulBaseTests {
    override func spec() {
        super.spec()

        describe("Configuration") {
            it("can generate an user-agent string") {
                let osVersion = NSProcessInfo.processInfo().operatingSystemVersionString
                let userAgentString = Configuration().userAgent

                expect(userAgentString).to(equal("contentful.swift/0.1.0 (iOS \(osVersion))"))
            }
        }

        describe("Scenarios from CDA documentation") {
            it("can fetch a space") {
                waitUntil(timeout: 10) { done in
                    self.client.fetchSpace().1.next { (space) in
                        expect(space.identifier).to(equal("cfexampleapi"))
                        expect(space.type).to(equal("Space"))
                        expect(space.name).to(equal("Contentful Example API"))
                    }.error { fail("\($0)") }.subscribe { _ in done() }
                }
            }
        }
    }
}
