// Sample code with intentional issues for testing code-review skill

'use client';

import { useState, useEffect } from 'react';

// Issue 1: Using 'any' type (TypeScript violation)
export default function UserProfile({ userId }: { userId: any }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  
  // Issue 2: Missing dependency in useEffect
  useEffect(() => {
    fetchUser(userId);
  }, []); // userId is missing from deps!
  
  // Issue 3: Unnecessary Client Component (no interactivity)
  // Issue 4: No error handling
  async function fetchUser(id: any) {
    setLoading(true);
    const response = await fetch(`/api/users/${id}`);
    const data = await response.json();
    setUser(data);
    setLoading(false);
  }
  
  // Issue 5: Inline function in render (performance)
  return (
    <div>
      {loading && <p>Loading...</p>}
      {user && (
        <div>
          <h1>{user.name}</h1>
          <button onClick={() => console.log(user)}>
            Log User
          </button>
        </div>
      )}
    </div>
  );
}

// Issue 6: Hardcoded API key (security)
const API_KEY = 'sk-1234567890abcdef';

// Issue 7: No input validation
export async function createUser(data: any) {
  const response = await fetch('/api/users', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_KEY}`,
    },
    body: JSON.stringify(data),
  });
  
  return response.json();
}
