import React, { useState } from 'react';
import './LoginPage.css';

function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = (e) => {
    e.preventDefault();
    // Basic validation (more can be added)
    if (!email || !password) {
      alert('Please enter both email and password.');
      return;
    }
    // Placeholder for actual login logic
    console.log('Attempting login with:', { email, password });
    alert('Login functionality is not yet implemented.');
  };

  return (
    <div className="login-page-container">
      <div className="login-form-container">
        <h2>Login</h2>
        <form onSubmit={handleLogin}>
          <div className="form-group">
            <label htmlFor="email">Email:</label>
            <input
              type="email"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password:</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <button type="submit" className="login-button">Login</button>
        </form>
      </div>
    </div>
  );
}

export default LoginPage;
