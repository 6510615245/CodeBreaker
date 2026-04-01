//
//  Code.swift
//  CodeBreaker
//
//  Created by นางสาวพลอยพรรณ เต็งประยูร on 28/1/2569 BE.
//


import Foundation
import SwiftData

@Model class Code {
    var _kind: String = Kind.unknown.description
    var pegs: [Peg]
    
    var kind: Kind {
        get { return Kind(_kind) }
        set { _kind = newValue.description }
    }
    
    init(kind: Kind, pegs: [Peg] = Array(repeating: Code.missing, count: 4)) {
        self.pegs = pegs
        self.kind = kind
    }
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempt([Match])
        case unknown
    }
    
    static let missing: Peg = ""
    
    func randomize(from pegChoices: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
        print(pegs)
    }
    
    func reset() {
        pegs = Array(repeating: Code.missing, count: 4)
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches): return matches
        default: return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        //var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        let backwardsExactMatches = pegs.indices.reversed().map { index in
            if pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }
        let exactMatches = Array(backwardsExactMatches.reversed())
        return pegs.indices.map { index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
        
//        for index in pegs.indices.reversed() {
//            if pegsToMatch[index] == pegs[index] {
//                results[index] = .exact
//                pegsToMatch.remove(at: index)
//            }
//        }
//        for index in pegs.indices {
//            if results[index] != .exact {
//                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
//                    results[index] = .inexact
//                    pegsToMatch.remove(at: matchIndex)
//                }
//            }
//        }
//        return results
    }
}

enum Match: String, Equatable {
    case nomatch
    case exact
    case inexact
}

extension Code.Kind {
    // MARK: - Serialization

    var description: String {
        switch self {
        case .master(let isHidden):
            return "master:\(isHidden ? "true" : "false")"
        case .guess:
            return "guess"
        case .attempt(let matches):
            let inner = matches.map { $0.rawValue }.joined(separator: ",")
            return "attempt:[\(inner)]"
        case .unknown:
            return "unknown"
        }
    }

    // MARK: - Non-failable initializer (falls back to .unknown)

    init(_ description: String) {
        let s = description.trimmingCharacters(in: .whitespacesAndNewlines)
        if s == "guess" {
            self = .guess; return
        }
        if s == "unknown" {
            self = .unknown; return
        }
        if s.hasPrefix("master:") {
            let valuePart = s.dropFirst("master:".count)
            switch valuePart {
            case "true":
                self = .master(isHidden: true); return
            case "false":
                self = .master(isHidden: false); return
            default:
                self = .unknown; return
            }
        }
        if s.hasPrefix("attempt:") {
            let valuePart = s.dropFirst("attempt:".count).trimmingCharacters(in: .whitespaces)
            guard valuePart.hasPrefix("[") && valuePart.hasSuffix("]") else {
                self = .unknown; return
            }
            let inner = valuePart.dropFirst().dropLast().trimmingCharacters(in: .whitespaces)
            if inner.isEmpty {
                self = .attempt([]); return
            }
            let components = inner.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            var matches: [Match] = []
            for comp in components {
                if let m = Match(rawValue: String(comp)) {
                    matches.append(m)
                } else {
                    self = .unknown; return
                }
            }
            self = .attempt(matches); return
        }

        self = .unknown
    }
}
