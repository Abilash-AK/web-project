from rest_framework import serializers
from .models import Review, Watched, ReviewLike
from users.serializers import UserSerializer


class ReviewSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    likes_count = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()
    
    class Meta:
        model = Review
        fields = (
            'id', 'user', 'movie_id', 'rating', 'review_text',
            'created_at', 'updated_at', 'likes_count', 'is_liked'
        )
        read_only_fields = ('id', 'user', 'created_at', 'updated_at')
    
    def get_likes_count(self, obj):
        return obj.likes.count()
    
    def get_is_liked(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
            return obj.likes.filter(user=request.user).exists()
        return False


class ReviewCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = ('movie_id', 'rating', 'review_text')
    
    def validate_rating(self, value):
        if value < 1 or value > 5:
            raise serializers.ValidationError("Rating must be between 1 and 5")
        return value


class WatchedSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = Watched
        fields = ('id', 'user', 'movie_id', 'watched_date', 'created_at')
        read_only_fields = ('id', 'user', 'created_at')


class WatchedCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Watched
        fields = ('movie_id', 'watched_date')


class ReviewLikeSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = ReviewLike
        fields = ('id', 'user', 'review', 'created_at')
        read_only_fields = ('id', 'user', 'created_at')
