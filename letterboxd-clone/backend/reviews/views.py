from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from django.shortcuts import get_object_or_404
from django.db import models

from .models import Review, Watched, ReviewLike
from .serializers import (
    ReviewSerializer, ReviewCreateSerializer,
    WatchedSerializer, WatchedCreateSerializer,
    ReviewLikeSerializer
)


class ReviewListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticatedOrReadOnly]
    
    def get_serializer_class(self):
        if self.request.method == 'POST':
            return ReviewCreateSerializer
        return ReviewSerializer
    
    def get_queryset(self):
        queryset = Review.objects.select_related('user').all()
        movie_id = self.request.query_params.get('movie_id')
        user_id = self.request.query_params.get('user_id')
        
        if movie_id:
            queryset = queryset.filter(movie_id=movie_id)
        if user_id:
            queryset = queryset.filter(user_id=user_id)
        
        return queryset
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class ReviewDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Review.objects.select_related('user').all()
    serializer_class = ReviewSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]
    
    def get_serializer_class(self):
        if self.request.method in ['PUT', 'PATCH']:
            return ReviewCreateSerializer
        return ReviewSerializer
    
    def update(self, request, *args, **kwargs):
        review = self.get_object()
        if review.user != request.user:
            return Response(
                {'error': 'You can only update your own reviews'},
                status=status.HTTP_403_FORBIDDEN
            )
        return super().update(request, *args, **kwargs)
    
    def destroy(self, request, *args, **kwargs):
        review = self.get_object()
        if review.user != request.user:
            return Response(
                {'error': 'You can only delete your own reviews'},
                status=status.HTTP_403_FORBIDDEN
            )
        return super().destroy(request, *args, **kwargs)


class WatchedListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticatedOrReadOnly]
    
    def get_serializer_class(self):
        if self.request.method == 'POST':
            return WatchedCreateSerializer
        return WatchedSerializer
    
    def get_queryset(self):
        queryset = Watched.objects.select_related('user').all()
        user_id = self.request.query_params.get('user_id')
        username = self.request.query_params.get('username')
        
        if user_id:
            queryset = queryset.filter(user_id=user_id)
        elif username:
            queryset = queryset.filter(user__username=username)
        
        return queryset
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class WatchedDetailView(generics.RetrieveDestroyAPIView):
    queryset = Watched.objects.select_related('user').all()
    serializer_class = WatchedSerializer
    permission_classes = [IsAuthenticated]
    
    def destroy(self, request, *args, **kwargs):
        watched = self.get_object()
        if watched.user != request.user:
            return Response(
                {'error': 'You can only delete your own watched entries'},
                status=status.HTTP_403_FORBIDDEN
            )
        return super().destroy(request, *args, **kwargs)


@api_view(['POST', 'DELETE'])
def toggle_review_like(request, review_id):
    if not request.user.is_authenticated:
        return Response(
            {'error': 'Authentication required'},
            status=status.HTTP_401_UNAUTHORIZED
        )
    
    review = get_object_or_404(Review, id=review_id)
    
    if request.method == 'POST':
        like, created = ReviewLike.objects.get_or_create(
            user=request.user,
            review=review
        )
        if created:
            return Response(
                {'message': 'Review liked', 'likes_count': review.likes.count()},
                status=status.HTTP_201_CREATED
            )
        return Response(
            {'message': 'Already liked', 'likes_count': review.likes.count()},
            status=status.HTTP_200_OK
        )
    
    elif request.method == 'DELETE':
        deleted_count, _ = ReviewLike.objects.filter(
            user=request.user,
            review=review
        ).delete()
        
        if deleted_count > 0:
            return Response(
                {'message': 'Like removed', 'likes_count': review.likes.count()},
                status=status.HTTP_200_OK
            )
        return Response(
            {'message': 'Like not found', 'likes_count': review.likes.count()},
            status=status.HTTP_404_NOT_FOUND
        )


@api_view(['GET'])
def user_stats(request, username):
    from django.contrib.auth import get_user_model
    User = get_user_model()
    
    user = get_object_or_404(User, username=username)
    
    reviews_count = Review.objects.filter(user=user).count()
    watched_count = Watched.objects.filter(user=user).count()
    avg_rating = Review.objects.filter(user=user).aggregate(
        models.Avg('rating')
    )['rating__avg'] or 0
    
    return Response({
        'username': user.username,
        'total_reviews': reviews_count,
        'total_watched': watched_count,
        'average_rating': round(avg_rating, 2)
    })
