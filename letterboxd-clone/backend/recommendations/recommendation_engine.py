from collections import Counter
from reviews.models import Review
from movies.tmdb_service import TMDbService
from movies.views import DEFAULT_MOVIES


class RecommendationEngine:
    
    @classmethod
    def get_user_recommendations(cls, user, limit=20):
        highly_rated_reviews = Review.objects.filter(
            user=user,
            rating__gte=4
        ).values_list('movie_id', flat=True)
        
        if not highly_rated_reviews:
            return (TMDbService.get_trending_movies() or DEFAULT_MOVIES)[:limit]
        
        genre_ids = cls._extract_genres_from_movies(highly_rated_reviews)
        
        if not genre_ids:
            return (TMDbService.get_trending_movies() or DEFAULT_MOVIES)[:limit]
        
        top_genres = [genre_id for genre_id, _ in Counter(genre_ids).most_common(3)]
        
        recommended_movies = TMDbService.discover_by_genres(top_genres, page=1) or DEFAULT_MOVIES
        
        reviewed_movie_ids = set(Review.objects.filter(user=user).values_list('movie_id', flat=True))
        
        filtered_recommendations = [
            movie for movie in recommended_movies 
            if movie.get('id') not in reviewed_movie_ids
        ]
        
        return (filtered_recommendations or DEFAULT_MOVIES)[:limit]
    
    @classmethod
    def _extract_genres_from_movies(cls, movie_ids):
        genre_ids = []
        
        for movie_id in movie_ids:
            movie_details = TMDbService.get_movie_details(movie_id)
            if movie_details and 'genres' in movie_details:
                for genre in movie_details['genres']:
                    genre_ids.append(genre['id'])
        
        return genre_ids
    
    @classmethod
    def get_similar_movies(cls, movie_id, limit=10):
        movie_details = TMDbService.get_movie_details(movie_id)
        
        if not movie_details or 'genres' not in movie_details:
            return []
        
        genre_ids = [genre['id'] for genre in movie_details['genres']]
        
        similar_movies = TMDbService.discover_by_genres(genre_ids, page=1) or DEFAULT_MOVIES or DEFAULT_MOVIES
        
        filtered_similar = [
            movie for movie in similar_movies 
            if movie.get('id') != movie_id
        ]
        
        return (filtered_similar or DEFAULT_MOVIES)[:limit]





