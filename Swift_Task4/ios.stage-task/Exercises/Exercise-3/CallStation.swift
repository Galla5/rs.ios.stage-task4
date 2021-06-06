import Foundation

final class CallStation {
    
    fileprivate var allUsers = [User]()
    fileprivate var allCalls = [Call]()
}

extension CallStation: Station {
    func users() -> [User] {
        return allUsers
    }
    
    func add(user: User) {
        guard !allUsers.contains(user) else { return }
        allUsers.append(user)
    }
    
    func remove(user: User) {
        guard let userIndex = allUsers.firstIndex(of: user) else { return }
        allUsers.remove(at: userIndex)
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let user1, to: let user2):
            let call = Call(id: UUID(), incomingUser: user1, outgoingUser: user2, status: .calling)
            allCalls.append(call)
            return call.id
        case .answer(from: let user):
            var currentCall = allCalls.first(where: { $0.incomingUser == user || $0.outgoingUser == user })
            guard currentCall != nil else { return nil }
            currentCall?.status = .talk
            if let index = allCalls.firstIndex(where: { $0.id == currentCall?.id }) {
                allCalls.remove(at: index)
            }
            allCalls.append(currentCall!)
            return currentCall!.id
        case .end(from: let user):
            var currentCall = allCalls.first(where: { $0.incomingUser == user || $0.outgoingUser == user })
            guard currentCall != nil else { return nil }
            currentCall?.status = .ended(reason: .end)
            if let index = allCalls.firstIndex(where: { $0.id == currentCall?.id }) {
                allCalls.remove(at: index)
            }
            allCalls.append(currentCall!)
            return currentCall!.id
        default:
            return nil
        }
    }
    
    func calls() -> [Call] {
        return allCalls
    }
    
    func calls(user: User) -> [Call] {
        allCalls.filter { $0.incomingUser == user || $0.outgoingUser == user }
    }
    
    func call(id: CallID) -> Call? {
        return allCalls.first(where: { $0.id == id })
    }
    
    func currentCall(user: User) -> Call? {
        return allCalls.first(where: { $0.incomingUser == user || $0.outgoingUser == user })
    }
}
