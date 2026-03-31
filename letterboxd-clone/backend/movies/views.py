from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.permissions import AllowAny

from .models import MovieCache
from .serializers import MovieCacheSerializer
from .tmdb_service import TMDbService


@api_view(['GET'])
def popular_movies(request):
    page = request.GET.get('page', 1)
    movies = TMDbService.get_popular_movies(page=page)
    return Response({'results': movies})


@api_view(['GET'])
def trending_movies(request):
    time_window = request.GET.get('time_window', 'week')
    movies = TMDbService.get_trending_movies(time_window=time_window)
    return Response({'results': movies})


@api_view(['GET'])
def movie_detail(request, movie_id):
    movie = TMDbService.get_movie_details(movie_id)
    
    if movie:
        MovieCache.objects.update_or_create(
            tmdb_id=movie_id,
            defaults={
                'title': movie.get('title', ''),
                'poster_path': movie.get('poster_path', ''),
                'backdrop_path': movie.get('backdrop_path', ''),
                'overview': movie.get('overview', ''),
                'release_date': movie.get('release_date'),
                'genres': movie.get('genres', []),
                'vote_average': movie.get('vote_average', 0),
                'vote_count': movie.get('vote_count', 0),
            }
        )
        return Response(movie)
    
    return Response(
        {'error': 'Movie not found'}, 
        status=status.HTTP_404_NOT_FOUND
    )


@api_view(['GET'])
def search_movies(request):
    query = request.GET.get('q', '')
    page = request.GET.get('page', 1)
    
    if not query:
        return Response(
            {'error': 'Query parameter is required'}, 
            status=status.HTTP_400_BAD_REQUEST
        )
    
    movies = TMDbService.search_movies(query, page=page)
    return Response({'results': movies})
