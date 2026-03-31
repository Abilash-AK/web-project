from django.contrib import admin
from .models import MovieCache


@admin.register(MovieCache)
class MovieCacheAdmin(admin.ModelAdmin):
    list_display = ('title', 'tmdb_id', 'release_date', 'vote_average', 'cached_at')
    list_filter = ('cached_at', 'release_date')
    search_fields = ('title', 'tmdb_id')
    readonly_fields = ('cached_at',)
