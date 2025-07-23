import SwiftUI

struct DashboardView: View {
    @State private var currentSteps: Int = 8312
    @State private var goalSteps: Int = 10000
    @State private var selectedPeriod: String = "Monthly"
    @State private var selectedTab: Int = 0
    
    private var stepsRemaining: Int {
        goalSteps - currentSteps
    }
    
    private var progressPercentage: Double {
        Double(currentSteps) / Double(goalSteps)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                Color(red: 0.984, green: 0.968, blue: 0.937)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // Header section
                        headerSection
                        
                        // Main content area
                        mainContentSection
                            .background(Color.white)
                            .cornerRadius(32, corners: [.topLeft, .topRight])
                            .padding(.top, 32)
                    }
                }
                
                // Bottom navigation
                VStack {
                    Spacer()
                    bottomNavigationBar
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.54), radius: 9, x: 1, y: 1)
                }
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                // Profile Avatar
                ZStack {
                    Circle()
                        .fill(Color(red: 0.941, green: 0.910, blue: 0.863))
                        .frame(width: 38, height: 38)
                    
                    Image(systemName: "person.fill")
                        .foregroundColor(Color(red: 1.0, green: 0.992, blue: 0.976))
                        .font(.system(size: 18))
                }
                
                Spacer()
                
                // Rewards section
                HStack(spacing: 16) {
                    rewardItem(color: Color(red: 1.0, green: 0.722, blue: 0.004), count: "12")
                    rewardItem(color: Color(red: 0.671, green: 0.741, blue: 0.773), count: "6")
                    rewardItem(color: Color(red: 0.651, green: 0.427, blue: 0.788), count: "2")
                }
            }
            .padding(.horizontal, 22)
            .padding(.top, 42)
            
            // Date section
            VStack(alignment: .leading, spacing: 10) {
                Text("April 21, Friday")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                    .padding(.horizontal, 21)
                
                Rectangle()
                    .fill(Color(red: 0.196, green: 0.110, blue: 0.110).opacity(0.13))
                    .frame(height: 1)
                    .padding(.horizontal, 21)
            }
            .padding(.top, 50)
            
            // Monster and progress section
            HStack(alignment: .top, spacing: 24) {
                // Monster character
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 148, height: 148)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                    
                    MonsterCharacterView()
                        .frame(width: 120, height: 120)
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 12) {
                    Text("You're almost there!")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(Color(red: 0.196, green: 0.110, blue: 0.110))
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Steps left to defeat ⚔️")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                        
                        Text("\(stepsRemaining)")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color(red: 0.196, green: 0.110, blue: 0.110))
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 31)
            .padding(.top, 30)
            
            // Progress bar section
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .leading) {
                    // Background bar
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color(red: 0.851, green: 0.820, blue: 0.761))
                        .frame(height: 11)
                    
                    // Progress bar
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color(red: 0.141, green: 0.722, blue: 0.459))
                        .frame(width: 315 * progressPercentage, height: 11)
                    
                    // Treasure chest icon
                    HStack {
                        Spacer()
                        treasureChestIcon
                            .offset(x: -10)
                    }
                }
                
                HStack {
                    Text("\(currentSteps) steps done")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                    
                    Spacer()
                    
                    Text("Goal \(goalSteps)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                }
            }
            .padding(.horizontal, 35)
            .padding(.top, 30)
        }
    }
    
    // MARK: - Main Content Section
    private var mainContentSection: some View {
        VStack(spacing: 20) {
            Text("Your Steps Progress")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(red: 0.196, green: 0.110, blue: 0.110))
                .padding(.top, 19)
            
            // Segmented control
            segmentedControl
                .padding(.horizontal, 15)
            
            // Stats section
            statsSection
                .padding(.horizontal, 17)
            
            // Chart section
            chartSection
                .padding(.horizontal, 16)
                .padding(.bottom, 120)
        }
    }
    
    // MARK: - Supporting Views
    private func rewardItem(color: Color, count: String) -> some View {
        HStack(spacing: 4) {
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    // Create hexagon shape
                    let points = [
                        CGPoint(x: width * 0.5, y: 0),
                        CGPoint(x: width * 0.933, y: height * 0.25),
                        CGPoint(x: width * 0.933, y: height * 0.75),
                        CGPoint(x: width * 0.5, y: height),
                        CGPoint(x: width * 0.067, y: height * 0.75),
                        CGPoint(x: width * 0.067, y: height * 0.25)
                    ]
                    
                    path.move(to: points[0])
                    for point in points.dropFirst() {
                        path.addLine(to: point)
                    }
                    path.closeSubpath()
                }
                .fill(color)
                .stroke(Color.white, lineWidth: 1)
            }
            .frame(width: 22, height: 24)
            
            Text(count)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 0.196, green: 0.110, blue: 0.110))
        }
    }
    
    private var treasureChestIcon: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.996, green: 0.988, blue: 0.973))
                .stroke(Color(red: 1.0, green: 0.780, blue: 0.0), lineWidth: 1)
                .frame(width: 43, height: 43)
            
            // Simplified treasure chest
            VStack(spacing: 2) {
                Rectangle()
                    .fill(Color(red: 0.510, green: 0.247, blue: 0.671))
                    .frame(width: 15, height: 8)
                    .cornerRadius(2)
                
                Rectangle()
                    .fill(Color(red: 0.510, green: 0.247, blue: 0.671))
                    .frame(width: 15, height: 12)
                    .cornerRadius(2)
            }
        }
    }
    
    private var segmentedControl: some View {
        HStack(spacing: 0) {
            segmentButton(title: "Daily", isSelected: selectedPeriod == "Daily")
            segmentButton(title: "Monthly", isSelected: selectedPeriod == "Monthly")
            segmentButton(title: "Yearly", isSelected: selectedPeriod == "Yearly")
        }
        .background(Color(red: 0.902, green: 0.883, blue: 0.847).opacity(0.33))
        .cornerRadius(100)
        .frame(height: 32)
    }
    
    private func segmentButton(title: String, isSelected: Bool) -> some View {
        Button(action: {
            selectedPeriod = title
        }) {
            Text(title)
                .font(.system(size: 15, weight: isSelected ? .semibold : .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 28)
                .background(
                    isSelected ? 
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 3)
                    : nil
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var statsSection: some View {
        HStack {
            statItem(title: "Average", value: "8,635")
            
            Rectangle()
                .fill(Color(red: 0.557, green: 0.557, blue: 0.576).opacity(0.3))
                .frame(width: 1, height: 49)
            
            statItem(title: "Best", value: "12,235")
        }
    }
    
    private func statItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
            
            HStack(spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("steps")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                    .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                }
                
                Spacer()
                
                Text("April , 2023")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(red: 0.196, green: 0.110, blue: 0.110))
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                }
            }
            
            // Chart
            chartView
        }
    }
    
    private var chartView: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Spacer()
                Text("12,000")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
            }
            
            HStack(alignment: .bottom, spacing: 6) {
                ForEach(0..<24, id: \.self) { index in
                    chartBar(height: CGFloat.random(in: 20...126))
                }
            }
            .frame(height: 140)
            
            HStack {
                Text("1")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                
                Spacer()
                
                Text("15")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
                
                Spacer()
                
                Text("30")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color(red: 0.529, green: 0.467, blue: 0.467))
            }
        }
    }
    
    private func chartBar(height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color(red: 1.0, green: 0.569, blue: 0.169))
            .frame(width: 8, height: height)
    }
    
    private var bottomNavigationBar: some View {
        HStack {
            navBarItem(icon: "chart.bar.fill", title: "Dashboard", index: 0)
            navBarItem(icon: "figure.strengthtraining.traditional", title: "Challenges", index: 1)
            navBarItem(icon: "figure.run", title: "Equipment", index: 2)
            navBarItem(icon: "bag.fill", title: "Shop", index: 3)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .frame(height: 82)
    }
    
    private func navBarItem(icon: String, title: String, index: Int) -> some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack(spacing: 6) {
                ZStack {
                    if selectedTab == index {
                        RoundedRectangle(cornerRadius: 1000)
                            .fill(Color(red: 0.965, green: 0.957, blue: 0.945))
                            .frame(width: 94, height: 59)
                    }
                    
                    VStack(spacing: 6) {
                        Image(systemName: icon)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        Text(title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Monster Character View
struct MonsterCharacterView: View {
    var body: some View {
        ZStack {
            // Main body
            Ellipse()
                .fill(Color(red: 0.510, green: 0.247, blue: 0.671))
                .frame(width: 80, height: 90)
            
            // Light purple overlay for body shading
            Ellipse()
                .fill(Color(red: 0.651, green: 0.427, blue: 0.788).opacity(0.7))
                .frame(width: 70, height: 80)
                .offset(y: -5)
            
            // Eyes
            HStack(spacing: 20) {
                // Left eye
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 18, height: 18)
                    
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 12, height: 12)
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                        .offset(x: 2)
                }
                
                // Right eye
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 18, height: 18)
                    
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 12, height: 12)
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                        .offset(x: 2)
                }
            }
            .offset(y: -15)
            
            // Mouth with teeth
            VStack(spacing: 2) {
                HStack(spacing: 3) {
                    ForEach(0..<6, id: \.self) { _ in
                        Rectangle()
                            .fill(.white)
                            .frame(width: 3, height: 8)
                    }
                }
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addQuadCurve(to: CGPoint(x: 30, y: 0), control: CGPoint(x: 15, y: 8))
                }
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 30, height: 8)
            }
            .offset(y: 10)
            
            // Small horns
            HStack(spacing: 40) {
                Triangle()
                    .fill(Color(red: 0.651, green: 0.427, blue: 0.788))
                    .frame(width: 8, height: 12)
                    .rotationEffect(.degrees(10))
                
                Triangle()
                    .fill(Color(red: 0.651, green: 0.427, blue: 0.788))
                    .frame(width: 8, height: 12)
                    .rotationEffect(.degrees(-10))
            }
            .offset(y: -45)
        }
    }
}

// MARK: - Triangle Shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
#Preview {
    DashboardView()
}
