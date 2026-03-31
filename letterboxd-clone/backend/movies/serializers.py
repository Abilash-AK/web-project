from rest_framework import serializers
from .models import MovieCache


class MovieCacheSerializer(serializers.ModelSerializer):
    poster_url = serializers.SerializerMethodField()
    backdrop_url = serializers.SerializerMethodField()
    
    class Meta:
        model = MovieCache
        fields = '__all__'
    
    def get_poster_url(self, obj):
        from .tmdb_service import TMDbService
        return TMDbService.get_poster_url(obj.poster_path)
    
    def get_backdrop_url(self, obj):
        from .tmdb_service import TMDbService
        return TMDbService.get_backdrop_url(obj.backdrop_path)
