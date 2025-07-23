import SwiftUI

struct DashboardView: View {
    @State private var selectedTimeframe = 1 // 0: Daily, 1: Monthly, 2: Yearly
    @State private var currentSteps = 8312
    @State private var goalSteps = 10000
    @State private var averageSteps = 8635
    @State private var bestSteps = 12235
    
    var remainingSteps: Int {
        max(0, goalSteps - currentSteps)
    }
    
    var progressPercentage: Double {
        Double(currentSteps) / Double(goalSteps)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header with profile and rewards
                HeaderView()
                
                // Date section
                DateSection()
                
                // Main motivational section
                MotivationalSection(remainingSteps: remainingSteps)
                
                // Progress bar section
                ProgressBarSection(
                    currentSteps: currentSteps,
                    goalSteps: goalSteps,
                    progressPercentage: progressPercentage
                )
                
                // Bottom white section with stats and chart
                VStack(spacing: 20) {
                    // Title
                    Text("Your Steps Progress")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(hex: "#321C1C"))
                        .padding(.top, 20)
                    
                    // Segmented control
                    TimeframeSelector(selectedTimeframe: $selectedTimeframe)
                    
                    // Statistics
                    StatsSection(averageSteps: averageSteps, bestSteps: bestSteps)
                    
                    // Chart
                    ChartSection()
                    
                    Spacer(minLength: 120) // Space for tab bar
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 32))
            }
        }
        .background(Color(hex: "#FBF7EF"))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            // Profile button
            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "#F0E8DC"))
                        .frame(width: 38, height: 38)
                    
                    Image(systemName: "person.fill")
                        .foregroundColor(Color(hex: "#FFFDF9"))
                        .font(.system(size: 16))
                }
            }
            
            Spacer()
            
            // Rewards section
            HStack(spacing: 16) {
                RewardBadge(count: 12, color: Color(hex: "#FFB801"))
                RewardBadge(count: 6, color: Color(hex: "#ABBEC5"))
                RewardBadge(count: 2, color: Color(hex: "#A66DC9"))
            }
        }
        .padding(.horizontal, 22)
        .padding(.top, 10)
    }
}

struct RewardBadge: View {
    let count: Int
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                // Star/gem shape
                Image(systemName: "diamond.fill")
                    .foregroundColor(color)
                    .font(.system(size: 20))
            }
            .frame(width: 22, height: 24)
            
            Text("\(count)")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(hex: "#321C1C"))
        }
    }
}

struct DateSection: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("April 21, Friday")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "#877777"))
                
                Spacer()
            }
            .padding(.horizontal, 22)
            
            Rectangle()
                .fill(Color(hex: "#321C1C").opacity(0.13))
                .frame(height: 1)
                .padding(.horizontal, 22)
        }
        .padding(.top, 15)
    }
}

struct MotivationalSection: View {
    let remainingSteps: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            // Monster character
            AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets%2F96bdcea875754831a96565514f304211%2F4c5703c7a0614c80be54a3c1b519e15a?format=webp&width=300")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Circle()
                    .fill(Color.white)
                    .overlay(
                        Image(systemName: "figure.run")
                            .font(.system(size: 40))
                            .foregroundColor(.purple)
                    )
            }
            .frame(width: 140, height: 140)
            .background(
                Circle()
                    .fill(Color.white)
                    .frame(width: 135, height: 135)
            )
            
            // Text section
            VStack(alignment: .leading, spacing: 8) {
                Text("You're almost\nthere!")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color(hex: "#321C1C"))
                    .lineLimit(nil)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Steps left to defeat ⚔️")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(hex: "#877777"))
                    
                    Text("\(remainingSteps)")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(hex: "#321C1C"))
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.top, 30)
    }
}

struct ProgressBarSection: View {
    let currentSteps: Int
    let goalSteps: Int
    let progressPercentage: Double
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(currentSteps) steps done")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(hex: "#877777"))
                
                Spacer()
                
                Text("Goal \(goalSteps)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(hex: "#877777"))
            }
            
            ZStack(alignment: .leading) {
                // Background bar
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color(hex: "#D9D1C2"))
                    .frame(height: 11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color.white.opacity(0.2), lineWidth: 4)
                    )
                
                // Progress bar
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color(hex: "#24B874"))
                    .frame(width: max(0, 315 * progressPercentage), height: 11)
            }
            .frame(width: 315)
            
            // Trophy badge
            HStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color(hex: "#FFC700"), lineWidth: 1)
                        .fill(Color(hex: "#FEFCF8"))
                        .frame(width: 43, height: 43)
                    
                    Image(systemName: "trophy.fill")
                        .foregroundColor(Color(hex: "#FFC700"))
                        .font(.system(size: 20))
                }
                .offset(x: -10)
            }
            .frame(width: 315)
        }
        .padding(.horizontal, 35)
        .padding(.top, 20)
        .padding(.bottom, 30)
    }
}

struct TimeframeSelector: View {
    @Binding var selectedTimeframe: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { index in
                Button(action: {
                    selectedTimeframe = index
                }) {
                    Text(["Daily", "Monthly", "Yearly"][index])
                        .font(.system(size: 15, weight: selectedTimeframe == index ? .semibold : .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 28)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(selectedTimeframe == index ? Color.white : Color.clear)
                                .shadow(color: selectedTimeframe == index ? .black.opacity(0.12) : .clear, radius: 3, y: 3)
                        )
                }
            }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(Color(hex: "#E6E1D8").opacity(0.33))
        )
        .frame(width: 359, height: 32)
    }
}

struct StatsSection: View {
    let averageSteps: Int
    let bestSteps: Int
    
    var body: some View {
        HStack {
            // Average
            VStack(alignment: .leading, spacing: 2) {
                Text("Average")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "#877777"))
                
                HStack(alignment: .bottom, spacing: 4) {
                    Text("\(averageSteps)")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("steps")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "#877777"))
                        .padding(.bottom, 2)
                }
            }
            
            Spacer()
            
            // Separator
            Rectangle()
                .fill(Color(hex: "#8E8E93").opacity(0.3))
                .frame(width: 1, height: 49)
            
            Spacer()
            
            // Best
            VStack(alignment: .leading, spacing: 2) {
                Text("Best")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "#877777"))
                
                HStack(alignment: .bottom, spacing: 4) {
                    Text("\(bestSteps)")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("steps")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "#877777"))
                        .padding(.bottom, 2)
                }
            }
        }
        .padding(.horizontal, 17)
    }
}

struct ChartSection: View {
    let chartData = [4, 6, 8, 5, 7, 12, 9, 10, 6, 8, 11, 7, 8, 12, 15, 10, 9, 11, 8, 6, 10, 14, 7, 9, 5, 8, 11, 6, 7, 4]
    
    var body: some View {
        VStack(spacing: 16) {
            // Navigation
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "#877777"))
                }
                
                Spacer()
                
                Text("April , 2023")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "#321C1C"))
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: "#877777"))
                }
            }
            .padding(.horizontal, 17)
            
            // Chart
            VStack {
                // Y-axis labels
                HStack {
                    Spacer()
                    VStack(spacing: 46) {
                        Text("12,000")
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(Color(hex: "#877777"))
                        Text("6,000")
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(Color(hex: "#877777"))
                    }
                }
                .frame(height: 120)
                
                // X-axis labels
                HStack {
                    Text("1")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color(hex: "#877777"))
                    
                    Spacer()
                    
                    Text("15")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color(hex: "#877777"))
                    
                    Spacer()
                    
                    Text("30")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color(hex: "#877777"))
                }
                .padding(.horizontal, 1)
            }
            .overlay(
                // Chart bars
                HStack(alignment: .bottom, spacing: 2) {
                    ForEach(0..<chartData.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(hex: "#FF912B"))
                            .frame(width: 8, height: CGFloat(chartData[index]) * 8)
                    }
                }
                .padding(.bottom, 15)
                .padding(.leading, 1)
            )
            .frame(width: 359, height: 140)
        }
        .padding(.horizontal, 16)
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    DashboardView()
}
