import SwiftUI

/// Root content view served by the Settings scene.
///
/// At this milestone `ContentView` acts as the live preview host. As features
/// are completed it will be replaced by the full Settings / Dashboard shell.
struct ContentView: View {

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "rectangle.on.rectangle.angled")
                .font(.system(size: 48, weight: .ultraLight))
                .foregroundStyle(.secondary)

            Text(AppConstants.App.name)
                .font(.title2)
                .fontWeight(.semibold)

            Text("v\(AppConstants.App.version)")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .frame(width: 480, height: 320)
        .glassCard()
        .padding(AppConstants.Window.defaultPadding)
    }
}

#Preview {
    ContentView()
}
