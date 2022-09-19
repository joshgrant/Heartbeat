//
//  Stock.swift
//  Client
//
//  Created by Joshua Grant on 9/16/22.
//

import Foundation

open class Stock
{
    // MARK: - Variables
    
    public var name: String?
    
    public var current: Double
    public var ideal: () -> Double?
    
    public var min: Double
    public var max: Double
    
    public var unit: Unit?
    
    // MARK: - Initialization
    
    public init(
        name: String? = nil,
        current: Double,
        ideal: @escaping () -> Double?,
        min: Double,
        max: Double,
        unit: Unit? = nil)
    {
        self.name = name
        self.current = current
        self.ideal = ideal
        self.min = min
        self.max = max
        self.unit = unit
    }
}

// MARK: - Stock protocol

extension Stock
{
    public var balance: Double?
    {
        guard let ideal = ideal() else { return nil }
        
        let delta = abs(current - ideal)
        let scale = Swift.max(max - ideal, ideal - min)
        return 1 - delta / scale
    }
    
    public var sign: ComparisonResult?
    {
        guard let ideal = ideal() else { return nil }
        if current > ideal
        {
            return .orderedAscending
        }
        else if current < ideal
        {
            return .orderedDescending
        }
        else
        {
            return .orderedSame
        }
    }
}

extension Stock: CustomStringConvertible
{
    public var description: String
    {
        "Stock (\(name ?? "")): \(current)"
    }
}

extension Stock: Equatable
{
    public static func ==(lhs: Stock, rhs: Stock) -> Bool
    {
        lhs === rhs
    }
}

// MARK: - Global stocks

extension Stock
{
    public static var source = Stock(
        name: "source",
        current: .infinity,
        ideal: { -.infinity },
        min: -.infinity,
        max: .infinity)
    
    public static var sink = Stock(
        name: "sink",
        current: -.infinity,
        ideal: { .infinity },
        min: -.infinity,
        max: .infinity)
}
