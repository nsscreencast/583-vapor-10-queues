import Vapor

struct GenerateEmailsCommand: AsyncCommand {
   struct Signature: CommandSignature {
        @Argument(name: "n", help: "how many emails to create")
        var count: Int
    }

    var help: String = "Generate a bunch of emails and enqueue them for testing."

    func run(using context: ConsoleKitCommands.CommandContext, signature: Signature) async throws {
        for i in 0..<signature.count {
            let email = EmailContent(to: "to", from: "from", subject: "subj", body: "Email #\(i)")
            try await context.application.queues.queue.dispatch(EmailJob.self, email)
        }
    }
}
