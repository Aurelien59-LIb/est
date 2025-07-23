import SwiftUI

@main
struct FitnessApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Dashboard")
                }
            
            ChallengesView()
                .tabItem {
                    Image(systemName: "target")
                    Text("Challenges")
                }
            
            EquipmentView()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Equipment")
                }
            
            ShopView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Shop")
                }
        }
        .accentColor(.primary)
    }
}

struct ChallengesView: View {
    var body: some View {
        VStack {
            Text("Challenges")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Coming Soon")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Challenges")
    }
}

struct EquipmentView: View {
    var body: some View {
        VStack {
            Text("Equipment")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Coming Soon")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Equipment")
    }
}

struct ShopView: View {
    var body: some View {
        VStack {
            Text("Shop")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Coming Soon")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Shop")
    }
}

#Preview {
    ContentView()
}
