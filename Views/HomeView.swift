import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest var account: FetchedResults<Account>
    
    @State private var userName: String = "159"
    @State private var password: String = "159"
    
    // Estado para el carrusel
    @State private var selectedImageIndex = 0
    
    init() {
        // Usa el nombre de usuario para inicializar la FetchRequest
        let predicate = NSPredicate(format: "userName == %@", "159")
        _account = FetchRequest<Account>(sortDescriptors: [], predicate: predicate)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) { 
                
                // Mostrar el nombre de usuario si está disponible
                if let userAccount = account.first {
                    Text("Bienvenido, \(userAccount.firstName ?? "Usuario")!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                } else {
                    Text("Bienvenido, Usuario!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                }

                // Título
                Text("SOBRE EL CCUNSA")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5) // Reducir el espaciado inferior

                // Carrusel de imágenes
                GeometryReader { geometry in
                    TabView(selection: $selectedImageIndex) {
                        Image("img1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                            .cornerRadius(10)
                            .clipped()
                            .tag(0)
                        
                        Image("img2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                            .cornerRadius(10)
                            .clipped()
                            .tag(1)
                        
                        Image("img3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                            .cornerRadius(10)
                            .clipped()
                            .tag(2)
                        
                        Image("img4")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                            .cornerRadius(10)
                            .clipped()
                            .tag(3)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                }
                .frame(height: 250)
                .padding(.bottom, 10)
                
                // Información sobre el Centro Cultural UNSA
                Text("""
                El Centro Cultural de la Universidad Nacional de San Agustín de Arequipa, es parte de la Oficina Universitaria de Promoción y Desarrollo Cultural.
                
                Desarrolla sus actividades en la calle Santa Catalina 101 en la Casona que perteneció a Don Juan Bautista Arróspide y Beláustegui quien la adquiere y concluye a fin del siglo XVIII, construcción iniciada en 1743 por doña María Gregoria Vda. de Benavides y Moscoso para ser Palacio Episcopal, aquí vivió el Obispo Don Pedro Chaves de la Rosa Galván y Amado durante algún tiempo se llamó “Palacio de la Inmaculada Concepción” en 1851, fue afectada y se le llamó “Casa Quemada”.
                
                En 1898 se transfirió la propiedad a Don Simón Yrriberry y posteriormente al Arzobispado de Arequipa.
                
                Actualmente el Centro Cultural UNSA cuenta con ocho (8) salas para exposiciones:
                Sala 1 Galería para Maestros
                Sala 2 Galería para Artistas
                Sala 3 Galería para obras tridimensionales
                Sala 4 Galería para artistas jóvenes
                Sala 5 Galería para pequeños formatos
                Sala 6 Galería de promoción
                Sala 7 Galería para invitados
                Sala 8 Galería de enlace
                
                Nuestra programación es anual, de marzo a enero y se renueva cada mes.
                """)
                .font(.body)
                .padding([.leading, .trailing]) // Espaciado uniforme en los laterales
                .padding(.bottom, 10) // Espacio debajo del texto
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear {
                validateLogin()
            }
        }
    }
    
    private func validateLogin() {
        if let userAccount = account.first {
            if userAccount.password == password {
                print("Ingreso exitoso")
            } else {
                print("Contraseña incorrecta")
            }
        }
    }
}
