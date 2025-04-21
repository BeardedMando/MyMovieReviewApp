//
//  ContentView.swift
//  MovieReviewApp
//
//  Created by German Bojorge on 4/20/25.
//

import SwiftUI
import CoreData

// ContentView
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Movie.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.date, ascending: false)]
    ) var movies: FetchedResults<Movie>

    @State private var showingAddMovieView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    VStack(alignment: .leading) {
                        Text(movie.name ?? "Unknown Movie")
                            .font(.headline)
                        Text("Review: \(movie.review ?? "No Review")")
                        HStack {
                            Text("Rating: \(String(format: "%.1f", movie.rating))/5")
                            Spacer()
                            Text("Date: \(movie.date?.formatted() ?? "Unknown")")
                        }
                        .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteMovies)
            }
            .navigationTitle("Movie Reviews")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddMovieView.toggle() }) {
                        Label("Add Movie", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddMovieView) {
                AddMovieView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deleteMovies(offsets: IndexSet) {
        withAnimation {
            offsets.map { movies[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// AddMovieView
struct AddMovieView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var review: String = ""
    @State private var rating: Double = 3
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Movie Details")) {
                    TextField("Movie Name", text: $name)
                    TextField("Review", text: $review)
                    Stepper("Rating: \(rating, specifier: "%.1f")", value: $rating, in: 1...5, step: 0.5)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Movie")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addMovie()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func addMovie() {
        withAnimation {
            let newMovie = Movie(context: viewContext)
            newMovie.name = name
            newMovie.review = review
            newMovie.rating = rating
            newMovie.date = date

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


