//
//  BalanceDisplayFormat.swift
//  BDKSwiftExampleWallet
//
//  Created by Matthew Ramsden on 2/3/25.
//

import Foundation

enum BalanceDisplayFormat: String, CaseIterable, Codable {
    case bitcoinSats = "bitcoinSats"
    case bitcoin = "btc"
    case sats = "sats"
    case bip21q = "bip21q"
    case fiat = "usd"
    case bip177 = "bip177"

    var displayText: String {
        switch self {
        case .sats, .bitcoinSats: return "sats"
        case .bitcoin, .bip177: return ""
        case .bip21q: return "₿"
        case .fiat: return "USD"
        }
    }
    
    func formatted(_ value: UInt64) -> String {
        switch self {
        case .sats:
            return value.formatted(.number)
        case .bitcoin:
            return String(format: "%.8f", Double(value) / 100_000_000)
        case .bitcoinSats:
            return value.formattedSatoshis()
        case .bip21q:
            return value.formatted(.number)
        case .fiat:
            return ""
//            return satsPrice.formatted(.number.precision(.fractionLength(2)))
        case .bip177:
            return value.formattedBip177()
        }
    }
        
}

extension BalanceDisplayFormat {
    var index: Int {
        BalanceDisplayFormat.allCases.firstIndex(of: self) ?? 0
    }
}
