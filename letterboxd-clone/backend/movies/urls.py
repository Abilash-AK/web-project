from django.urls import path
from . import views

urlpatterns = [
    path('popular/', views.popular_movies, name='popular-movies'),
    path('trending/', views.trending_movies, name='trending-movies'),
    path('search/', views.search_movies, name='search-movies'),
    path('<int:movie_id>/', views.movie_detail, name='movie-detail'),
]
