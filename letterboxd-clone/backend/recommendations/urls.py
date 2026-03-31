from django.urls import path
from . import views

urlpatterns = [
    path('', views.get_recommendations, name='recommendations'),
    path('similar/<int:movie_id>/', views.get_similar_movies, name='similar-movies'),
]
