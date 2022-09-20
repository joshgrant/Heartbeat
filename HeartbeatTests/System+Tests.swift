//
//  System+Tests.swift
//  HeartbeatTests
//
//  Created by Joshua Grant on 9/15/22.
//

import XCTest
@testable import Heartbeat

final class System_Tests: XCTestCase
{
    func test_balance_noStocks()
    {
        let system = System()
        XCTAssertEqual(system.balance, 1)
    }
    
    func test_balance_oneStock()
    {
        let system = System()
        system.stocks = [
            .init(
                unit: UnitArea.ares,
                current: { 5 },
                maximum: { 100 },
                ideal: { 20 })
        ]
        
        XCTAssertEqual(system.balance, 0.85)
    }
    
    func test_balance_twoStocks()
    {
        let system = System()
        system.stocks = [
            .init(
                unit: UnitArea.ares,
                current: { 5 },
                maximum: { 100 },
                ideal: { 20 }),
            .init(
                unit: UnitArea.ares,
                current: { 20 },
                maximum: { 100 },
                ideal: { 50 })
        ]
        XCTAssertEqual(system.balance, 0.775)
    }
    
    func test_balance_twoBondedStocks()
    {
        let system = System()
        let stockA = Stock(
            unit: UnitArea.acres,
            current: { 5 },
            maximum: { 100 },
            ideal: { 0 })
        let stockB = Stock(
            unit: UnitArea.acres,
            current: { 20 },
            maximum: { 100 },
            ideal: { 30 })
        let bond = Bond(lhs: stockA, rhs: stockB)
        
        system.stocks = [stockA, stockB]
        system.bonds = [bond]
        
        XCTAssertEqual(system.balance, 0.975)
    }
    
    func test_balance_twoBondedStocks_oneUnbondedStock()
    {
        let system = System()
        let stockA = Stock(
            unit: UnitArea.acres,
            current: { 5 },
            maximum: { 100 },
            ideal: { 0 })
        let stockB = Stock(
            unit: UnitArea.acres,
            current: { 20 },
            maximum: { 100 },
            ideal: { 30 })
        let stockC = Stock(
            unit: UnitArea.acres,
            current: { 0 },
            maximum: { 100 },
            ideal: { 100 })
        let bond = Bond(lhs: stockA, rhs: stockB)
        
        system.stocks = [stockA, stockB, stockC]
        system.bonds = [bond]
        
        XCTAssertEqual(system.balance, 0.65)
    }
}
