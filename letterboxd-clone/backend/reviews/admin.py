from django.contrib import admin
from .models import Review, Watched, ReviewLike


@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    list_display = ('user', 'movie_id', 'rating', 'created_at')
    list_filter = ('rating', 'created_at')
    search_fields = ('user__username', 'movie_id', 'review_text')
    readonly_fields = ('created_at', 'updated_at')


@admin.register(Watched)
class WatchedAdmin(admin.ModelAdmin):
    list_display = ('user', 'movie_id', 'watched_date', 'created_at')
    list_filter = ('watched_date', 'created_at')
    search_fields = ('user__username', 'movie_id')
    readonly_fields = ('created_at',)


@admin.register(ReviewLike)
class ReviewLikeAdmin(admin.ModelAdmin):
    list_display = ('user', 'review', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'review__id')
    readonly_fields = ('created_at',)
