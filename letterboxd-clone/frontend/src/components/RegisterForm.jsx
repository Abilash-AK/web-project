import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const RegisterForm = () => {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: '',
    password2: '',
    first_name: '',
    last_name: '',
  });
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  
  const { register } = useAuth();
  const navigate = useNavigate();

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrors({});
    setLoading(true);

    const result = await register(formData);

    if (result.success) {
      navigate('/');
    } else {
      setErrors(result.error);
    }

    setLoading(false);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {errors.non_field_errors && (
        <div className="bg-red-500/10 border border-red-500 text-red-500 px-4 py-3 rounded-md">
          {errors.non_field_errors}
        </div>
      )}

      <div>
        <label htmlFor="username" className="block text-sm font-medium text-text-secondary mb-2">
          Username *
        </label>
        <input
          id="username"
          name="username"
          type="text"
          value={formData.username}
          onChange={handleChange}
          required
          className="input-field"
          placeholder="Choose a username"
        />
        {errors.username && (
          <p className="mt-1 text-sm text-red-500">{errors.username[0]}</p>
        )}
      </div>

      <div>
        <label htmlFor="email" className="block text-sm font-medium text-text-secondary mb-2">
          Email *
        </label>
        <input
          id="email"
          name="email"
          type="email"
          value={formData.email}
          onChange={handleChange}
          required
          className="input-field"
          placeholder="your@email.com"
        />
        {errors.email && (
          <p className="mt-1 text-sm text-red-500">{errors.email[0]}</p>
        )}
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label htmlFor="first_name" className="block text-sm font-medium text-text-secondary mb-2">
            First Name
          </label>
          <input
            id="first_name"
            name="first_name"
            type="text"
            value={formData.first_name}
            onChange={handleChange}
            className="input-field"
            placeholder="First name"
          />
        </div>

        <div>
          <label htmlFor="last_name" className="block text-sm font-medium text-text-secondary mb-2">
            Last Name
          </label>
          <input
            id="last_name"
            name="last_name"
            type="text"
            value={formData.last_name}
            onChange={handleChange}
            className="input-field"
            placeholder="Last name"
          />
        </div>
      </div>

      <div>
        <label htmlFor="password" className="block text-sm font-medium text-text-secondary mb-2">
          Password *
        </label>
        <input
          id="password"
          name="password"
          type="password"
          value={formData.password}
          onChange={handleChange}
          required
          className="input-field"
          placeholder="Create a password"
        />
        {errors.password && (
          <p className="mt-1 text-sm text-red-500">{errors.password[0]}</p>
        )}
      </div>

      <div>
        <label htmlFor="password2" className="block text-sm font-medium text-text-secondary mb-2">
          Confirm Password *
        </label>
        <input
          id="password2"
          name="password2"
          type="password"
          value={formData.password2}
          onChange={handleChange}
          required
          className="input-field"
          placeholder="Confirm your password"
        />
        {errors.password2 && (
          <p className="mt-1 text-sm text-red-500">{errors.password2[0]}</p>
        )}
      </div>

      <button
        type="submit"
        disabled={loading}
        className="w-full btn-primary disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {loading ? 'Creating account...' : 'Create Account'}
      </button>
    </form>
  );
};

export default RegisterForm;
