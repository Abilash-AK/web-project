import { useState, useEffect } from 'react';
import RatingStars from './RatingStars';

const ReviewForm = ({ onSubmit, initialData, loading }) => {
  const [rating, setRating] = useState(initialData?.rating || 0);
  const [reviewText, setReviewText] = useState(initialData?.review_text || '');

  useEffect(() => {
    if (initialData) {
      setRating(initialData.rating || 0);
      setReviewText(initialData.review_text || '');
    }
  }, [initialData]);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (rating === 0) {
      alert('Please select a rating');
      return;
    }
    onSubmit({ rating, review_text: reviewText });
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div>
        <label className="block text-sm font-medium text-text-secondary mb-2">
          Your Rating *
        </label>
        <RatingStars rating={rating} onRatingChange={setRating} size="large" />
      </div>

      <div>
        <label htmlFor="review" className="block text-sm font-medium text-text-secondary mb-2">
          Your Review (optional)
        </label>
        <textarea
          id="review"
          value={reviewText}
          onChange={(e) => setReviewText(e.target.value)}
          rows={6}
          className="input-field resize-none"
          placeholder="Share your thoughts about this movie..."
        />
      </div>

      <button
        type="submit"
        disabled={loading || rating === 0}
        className="btn-primary disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {loading ? 'Submitting...' : initialData ? 'Update Review' : 'Submit Review'}
      </button>
    </form>
  );
};

export default ReviewForm;
