import SwiftUI
import MapKit
import EventKit


struct UserProfileView: View {
    @State private var showEditProfile = false
    @State private var showAppointmentHistory = false
    @State private var showFavorites = false
    @State private var showHairProfile = false
    @State private var showAchievements = false
    @State private var showCommunityActivity = false
    @State private var showSettings = false
    @State private var showSupport = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // MARK: - Profile Header
                    HStack {
                        Image("image-3") // Replace with your image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .scaleEffect(showEditProfile ? 1.1 : 1) // Animation for profile image
                            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: showEditProfile)
                        
                        VStack(alignment: .leading) {
                            Text("Jessica")
                                .font(.system(size: 24, weight: .bold))
                            Text("Natural Hair Enthusiast")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - Edit Profile Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showEditProfile.toggle()
                        }
                    }) {
                        Text("Edit Profile")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .scaleEffect(showEditProfile ? 0.95 : 1) // Button press animation
                    }
                    .padding(.horizontal, 16)
                    .sheet(isPresented: $showEditProfile) {
                        EditProfileView()
                    }
                    
                    // MARK: - Find Stylist Button
                    NavigationLink(destination: FindStylistView()) {
                        Text("Find a Stylist & Schedule a Visit")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .scaleEffect(showAppointmentHistory ? 0.95 : 1) // Button press animation
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - Sections
                    ProfileSection(title: "Appointment History") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showAppointmentHistory.toggle()
                        }
                    }
                    .sheet(isPresented: $showAppointmentHistory) {
                        AppointmentHistoryView()
                    }
                    
                    ProfileSection(title: "Favorites") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showFavorites.toggle()
                        }
                    }
                    .sheet(isPresented: $showFavorites) {
                        FavoritesView()
                    }
                    
                    ProfileSection(title: "Hair Profile") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showHairProfile.toggle()
                        }
                    }
                    .sheet(isPresented: $showHairProfile) {
                        HairProfileView()
                    }
                    
                    ProfileSection(title: "Achievements") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showAchievements.toggle()
                        }
                    }
                    .sheet(isPresented: $showAchievements) {
                        AchievementsView()
                    }
                    
                    ProfileSection(title: "Community Activity") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showCommunityActivity.toggle()
                        }
                    }
                    .sheet(isPresented: $showCommunityActivity) {
                        CommunityActivityView()
                    }
                    
                    ProfileSection(title: "Settings") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showSettings.toggle()
                        }
                    }
                    .sheet(isPresented: $showSettings) {
                        SettingsView()
                    }
                    
                    ProfileSection(title: "Support") {
                        EmptyView() // Placeholder for action
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showSupport.toggle()
                        }
                    }
                    .sheet(isPresented: $showSupport) {
                        SupportView()
                    }
                    
                    // MARK: - Logout Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            print("User logged out")
                        }
                    }) {
                        Text("Logout")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .scaleEffect(showSettings ? 0.95 : 1) // Button press animation
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 16)
            }
            .navigationTitle("Profile")
        }
    }
}

// MARK: - Profile Section View
struct ProfileSection<Content: View>: View {
    let title: String
    let action: () -> Content
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .medium))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .scaleEffect(1) // Default scale
        .animation(.easeInOut(duration: 0.2), value: title) // Animation for section tap
    }
}

// MARK: - Edit Profile View
struct EditProfileView: View {
    @State private var name: String = "Jessica"
    @State private var bio: String = "Natural Hair Enthusiast"
    @State private var email: String = "jessica@example.com"
    @State private var phone: String = "+1 234 567 890"
    @State private var isEditing: Bool = false // Track editing state
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: - Profile Picture Section
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 120, height: 120)
                            .shadow(radius: 5)
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .scaleEffect(isEditing ? 1.1 : 1) // Animation for profile picture
                            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: isEditing)
                    }
                    .padding(.top, 20)
                    
                    // MARK: - Profile Information Section
                    VStack(spacing: 16) {
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Name")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter your name", text: $name)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 1) // Border animation
                                    )
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            isEditing = true
                                        }
                                    }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Bio")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter your bio", text: $bio)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 1) // Border animation
                                    )
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            isEditing = true
                                        }
                                    }
                            }
                        }
                        
                        // MARK: - Contact Information Section
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter your email", text: $email)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 1) // Border animation
                                    )
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            isEditing = true
                                        }
                                    }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Phone")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter your phone number", text: $phone)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 1) // Border animation
                                    )
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            isEditing = true
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - Save Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            print("Profile saved")
                            isEditing = false
                        }
                    }) {
                        Text("Save")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(isEditing ? Color.blue : Color.blue.opacity(0.5)) // Button color animation
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .scaleEffect(isEditing ? 1.05 : 1) // Button press animation
                    }
                    .padding(.horizontal, 16)
                    .disabled(!isEditing) // Disable button when not editing
                    .opacity(isEditing ? 1 : 0.7) // Fade animation for button
                    .animation(.easeInOut(duration: 0.3), value: isEditing)
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isEditing.toggle()
                        }
                    }) {
                        Text(isEditing ? "Done" : "Edit")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

// MARK: - Appointment History View
struct AppointmentHistoryView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Upcoming Appointments")) {
                    Text("Haircut with Stylist A - Jan 15, 2024")
                    Text("Hair Treatment with Stylist B - Feb 1, 2024")
                }
                Section(header: Text("Past Appointments")) {
                    Text("Hair Treatment with Stylist B - Dec 20, 2023")
                    Text("Haircut with Stylist A - Nov 10, 2023")
                }
            }
            .navigationTitle("Appointment History")
        }
    }
}

// MARK: - Favorites View
struct FavoritesView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Favorite Stylists")) {
                    Text("Stylist A")
                    Text("Stylist B")
                }
                Section(header: Text("Favorite Products")) {
                    Text("Shea Moisture Shampoo")
                    Text("Cantu Leave-In Conditioner")
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

// MARK: - Hair Profile View
struct HairProfileView: View {
    @State private var hairType: String = "4C"
    @State private var hairConcerns: String = "Dryness, Breakage"
    @State private var hairGoals: String = "Length Retention, Moisture"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hair Type")) {
                    TextField("Hair Type", text: $hairType)
                }
                Section(header: Text("Hair Concerns")) {
                    TextField("Hair Concerns", text: $hairConcerns)
                }
                Section(header: Text("Hair Goals")) {
                    TextField("Hair Goals", text: $hairGoals)
                }
            }
            .navigationTitle("Hair Profile")
            .toolbar {
                Button("Save") {
                    print("Hair profile saved")
                }
            }
        }
    }
}

// MARK: - Achievements View
struct AchievementsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Badges")) {
                    Text("5 Appointments Completed")
                    Text("10 Community Posts")
                }
                Section(header: Text("Loyalty Points")) {
                    Text("500 Points")
                }
            }
            .navigationTitle("Achievements")
        }
    }
}

// MARK: - Community Activity View
struct CommunityActivityView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Posts")) {
                    Text("Check out my new twist-out!")
                    Text("Loving these products!")
                }
                Section(header: Text("Comments")) {
                    Text("This looks amazing!")
                    Text("Great job!")
                }
                Section(header: Text("Likes")) {
                    Text("Liked: Stylist A's Post")
                    Text("Liked: Stylist B's Post")
                }
            }
            .navigationTitle("Community Activity")
        }
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var privacySettings: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }
                Section(header: Text("Privacy")) {
                    Toggle("Make Profile Public", isOn: $privacySettings)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// MARK: - Support View
struct SupportView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Help & Support")) {
                    Text("Contact Support")
                    Text("FAQ")
                }
            }
            .navigationTitle("Support")
        }
    }
}

// MARK: - Find Stylist View
struct FindStylistView: View {
    @State private var searchText: String = ""
    @State private var selectedDate: Date = Date()
    @State private var showCalendar: Bool = false
    @State private var stylists: [Stylist] = [
        Stylist(name: "Stylist A", location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),
        Stylist(name: "Stylist B", location: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4294)),
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            // MARK: - Search Bar
            TextField("Search for stylists...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
            
            // MARK: - Map View
            MapView(stylists: $stylists)
                .frame(height: 300)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .shadow(radius: 5)
                .scaleEffect(showCalendar ? 0.95 : 1) // Map animation
                .animation(.easeInOut(duration: 0.3), value: showCalendar)
            
            // MARK: - Date Picker
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showCalendar.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "calendar")
                    Text("Select Date & Time")
                }
                .font(.system(size: 16, weight: .medium))
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 5)
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showCalendar) {
                DatePicker("Select Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
            }
            
            // MARK: - Schedule Button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    scheduleAppointment()
                }
            }) {
                Text("Schedule Visit")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 16)
        .navigationTitle("Find a Stylist")
    }
    
    // MARK: - Schedule Appointment Function
    private func scheduleAppointment() {
        let eventStore = EKEventStore()
        
        // Request calendar access
        eventStore.requestAccess(to: .event) { granted, error in
            if granted, error == nil {
                let event = EKEvent(eventStore: eventStore)
                event.title = "Hair Appointment with Stylist"
                event.startDate = selectedDate
                event.endDate = selectedDate.addingTimeInterval(3600) // 1 hour appointment
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                do {
                    try eventStore.save(event, span: .thisEvent)
                    print("Appointment scheduled successfully!")
                } catch {
                    print("Failed to save appointment: \(error.localizedDescription)")
                }
            } else {
                print("Calendar access denied or error: \(String(describing: error))")
            }
        }
    }
}

// MARK: - Stylist Model
struct Stylist: Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
}

// MARK: - Map View
struct MapView: UIViewRepresentable {
    @Binding var stylists: [Stylist]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Add annotations for stylists
        uiView.removeAnnotations(uiView.annotations)
        for stylist in stylists {
            let annotation = MKPointAnnotation()
            annotation.coordinate = stylist.location
            annotation.title = stylist.name
            uiView.addAnnotation(annotation)
        }
        
        // Set the map region to show all stylists
        if let firstStylist = stylists.first {
            let region = MKCoordinateRegion(
                center: firstStylist.location,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            uiView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
