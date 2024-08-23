import Vapor
import Queues

struct EmailContent: Codable {
    let to: String
    let from: String
    let subject: String
    let body: String
}

struct EmailJob: AsyncJob {
    typealias Payload = EmailContent

    func dequeue(_ context: QueueContext, _ payload: EmailContent) async throws {
        try await Task.sleep(for: .seconds(2))
        print("[Sending email] 📩 \(payload)")
    }

    func error(_ context: QueueContext, _ error: any Error, _ payload: EmailContent) async throws {
        // handle error?
    }
}
