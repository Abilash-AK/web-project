from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status

from .recommendation_engine import RecommendationEngine


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_recommendations(request):
    limit = int(request.GET.get('limit', 20))
    recommendations = RecommendationEngine.get_user_recommendations(
        request.user, 
        limit=limit
    )
    
    return Response({
        'results': recommendations,
        'count': len(recommendations)
    })


@api_view(['GET'])
def get_similar_movies(request, movie_id):
    limit = int(request.GET.get('limit', 10))
    similar_movies = RecommendationEngine.get_similar_movies(
        movie_id,
        limit=limit
    )
    
    return Response({
        'results': similar_movies,
        'count': len(similar_movies)
    })
