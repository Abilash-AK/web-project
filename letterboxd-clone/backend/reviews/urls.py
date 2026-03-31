from django.urls import path
from . import views

urlpatterns = [
    path('', views.ReviewListCreateView.as_view(), name='review-list-create'),
    path('<int:pk>/', views.ReviewDetailView.as_view(), name='review-detail'),
    path('<int:review_id>/like/', views.toggle_review_like, name='toggle-review-like'),
    path('watched/', views.WatchedListCreateView.as_view(), name='watched-list-create'),
    path('watched/<int:pk>/', views.WatchedDetailView.as_view(), name='watched-detail'),
    path('users/<str:username>/stats/', views.user_stats, name='user-stats'),
]
