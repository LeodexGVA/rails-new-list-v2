require "json"
# Permet de nettoyer la DB à chaque pousser de seed
Movie.destroy_all
Movie.destroy_all
List.destroy_all

# Message d'affichage
puts "Cleaning DB"
puts "Creating movies..."

tmdb_url = "http://tmdb.lewagon.com/movie/top_rated?api_key=d5b8dd28dbdc765030324d1fdfdb1cde"

# Effectuer une requête GET et récupérer les données JSON
response = URI.open(tmdb_url)
movies_data = JSON.parse(response.read)

# Créer un fichier de vue pour formater les données JSON
jbuilder_template = Jbuilder.new do |json|
  json.array! movies_data['results'] do |movie_data|
    json.title movie_data['title']
    json.overview movie_data['overview']
    json.poster_url "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}"
    json.rating movie_data['vote_average']
  end
end

# Créer des films à partir des données formatées
jbuilder_result = JSON.parse(jbuilder_template.target!)
jbuilder_result.each do |movie_data|
  Movie.create!(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: movie_data['poster_url'],
    rating: movie_data['rating']
  )
end
puts "Finished!"
