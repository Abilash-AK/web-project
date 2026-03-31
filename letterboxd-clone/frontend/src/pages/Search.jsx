import { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import axiosInstance from '../utils/axios';
import MovieCard from '../components/MovieCard';

const Search = () => {
  const [searchParams, setSearchParams] = useSearchParams();
  const [query, setQuery] = useState(searchParams.get('q') || '');
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);
  const [searched, setSearched] = useState(false);

  useEffect(() => {
    const q = searchParams.get('q');
    if (q) {
      setQuery(q);
      performSearch(q);
    }
  }, [searchParams]);

  const performSearch = async (searchQuery) => {
    if (!searchQuery.trim()) return;

    setLoading(true);
    setSearched(true);

    try {
      const response = await axiosInstance.get(`/movies/search/?q=${encodeURIComponent(searchQuery)}`);
      setResults(response.data.results || []);
    } catch (error) {
      console.error('Search error:', error);
      setResults([]);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (query.trim()) {
      setSearchParams({ q: query.trim() });
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="max-w-2xl mx-auto mb-12">
        <h1 className="text-4xl font-bold text-white mb-8 text-center">Search Movies</h1>
        
        <form onSubmit={handleSubmit} className="flex space-x-4">
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Enter movie title..."
            className="flex-1 input-field"
          />
          <button type="submit" className="btn-primary">
            Search
          </button>
        </form>
      </div>

      {loading && (
        <div className="flex items-center justify-center h-64">
          <div className="text-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-accent-green mx-auto mb-4"></div>
            <p className="text-text-secondary">Searching...</p>
          </div>
        </div>
      )}

      {!loading && searched && results.length === 0 && (
        <div className="text-center py-12">
          <p className="text-text-secondary text-lg">
            No movies found for "{searchParams.get('q')}". Try a different search.
          </p>
        </div>
      )}

      {!loading && results.length > 0 && (
        <div>
          <p className="text-text-secondary mb-6">
            Found {results.length} result{results.length !== 1 ? 's' : ''} for "{searchParams.get('q')}"
          </p>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
            {results.map((movie) => (
              <MovieCard key={movie.id} movie={movie} />
            ))}
          </div>
        </div>
      )}

      {!loading && !searched && (
        <div className="text-center py-12">
          <p className="text-text-secondary text-lg">
            Enter a movie title to start searching
          </p>
        </div>
      )}
    </div>
  );
};

export default Search;
