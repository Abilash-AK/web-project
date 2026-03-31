import requests
from django.conf import settings
from datetime import datetime


class TMDbService:
    BASE_URL = settings.TMDB_BASE_URL
    API_KEY = settings.TMDB_API_KEY
    IMAGE_BASE_URL = settings.TMDB_IMAGE_BASE_URL
    
    @classmethod
    def _make_request(cls, endpoint, params=None):
        if params is None:
            params = {}
        params['api_key'] = cls.API_KEY
        
        try:
            response = requests.get(f"{cls.BASE_URL}{endpoint}", params=params)
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"TMDb API Error: {e}")
            return None
    
    @classmethod
    def get_popular_movies(cls, page=1):
        data = cls._make_request('/movie/popular', {'page': page})
        return data.get('results', []) if data else []
    
    @classmethod
    def get_movie_details(cls, movie_id):
        return cls._make_request(f'/movie/{movie_id}')
    
    @classmethod
    def search_movies(cls, query, page=1):
        data = cls._make_request('/search/movie', {'query': query, 'page': page})
        return data.get('results', []) if data else []
    
    @classmethod
    def get_trending_movies(cls, time_window='week'):
        data = cls._make_request(f'/trending/movie/{time_window}')
        return data.get('results', []) if data else []
    
    @classmethod
    def discover_by_genres(cls, genre_ids, page=1):
        genre_string = ','.join(map(str, genre_ids))
        data = cls._make_request('/discover/movie', {
            'with_genres': genre_string,
            'sort_by': 'popularity.desc',
            'page': page
        })
        return data.get('results', []) if data else []
    
    @classmethod
    def get_poster_url(cls, poster_path, size='w500'):
        if not poster_path:
            return None
        return f"{cls.IMAGE_BASE_URL}/{size}{poster_path}"
    
    @classmethod
    def get_backdrop_url(cls, backdrop_path, size='w1280'):
        if not backdrop_path:
            return None
        return f"{cls.IMAGE_BASE_URL}/{size}{backdrop_path}"
