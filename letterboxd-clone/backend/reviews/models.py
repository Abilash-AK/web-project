from django.db import models
from django.conf import settings
from django.core.validators import MinValueValidator, MaxValueValidator


class Review(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE,
        related_name='reviews'
    )
    movie_id = models.IntegerField(db_index=True)
    rating = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)]
    )
    review_text = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'reviews'
        ordering = ['-created_at']
        unique_together = ['user', 'movie_id']
    
    def __str__(self):
        return f"{self.user.username} - Movie {self.movie_id} - {self.rating}★"


class Watched(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='watched_movies'
    )
    movie_id = models.IntegerField(db_index=True)
    watched_date = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        db_table = 'watched'
        ordering = ['-watched_date']
        unique_together = ['user', 'movie_id']
    
    def __str__(self):
        return f"{self.user.username} watched Movie {self.movie_id} on {self.watched_date}"


class ReviewLike(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='review_likes'
    )
    review = models.ForeignKey(
        Review,
        on_delete=models.CASCADE,
        related_name='likes'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        db_table = 'review_likes'
        unique_together = ['user', 'review']
    
    def __str__(self):
        return f"{self.user.username} liked review {self.review.id}"
