import React, { useState } from 'react';

function App() {
  const [key, setKey] = useState('test_key');
  const [value, setValue] = useState('test_value');
  const [result, setResult] = useState('');
  const [loading, setLoading] = useState(false);

  // All styles defined as JavaScript objects
  const styles = {
    app: {
      fontFamily: 'Arial, sans-serif',
      maxWidth: '800px',
      margin: '0 auto',
      padding: '20px',
      textAlign: 'center'
    },
    header: {
      color: '#2c3e50',
      marginBottom: '30px'
    },
    controlGroup: {
      marginBottom: '20px',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      gap: '10px'
    },
    input: {
      padding: '10px',
      width: '300px',
      borderRadius: '4px',
      border: '1px solid #ddd',
      fontSize: '16px'
    },
    button: {
      padding: '10px 20px',
      backgroundColor: '#3498db',
      color: 'white',
      border: 'none',
      borderRadius: '4px',
      cursor: 'pointer',
      fontSize: '16px',
      margin: '0 5px',
      transition: 'background-color 0.3s'
    },
    buttonHover: {
      backgroundColor: '#2980b9'
    },
    resultBox: {
      marginTop: '30px',
      padding: '20px',
      backgroundColor: '#f8f9fa',
      borderRadius: '4px',
      border: '1px solid #eee',
      textAlign: 'left',
      minHeight: '100px'
    },
    loading: {
      color: '#7f8c8d'
    }
  };

  const testRedis = async (action) => {
    setLoading(true);
    try {
      const response = await fetch(
        `/api/redis?action=${action}&key=${encodeURIComponent(key)}&value=${encodeURIComponent(value)}`
      );
      const data = await response.json();
      setResult(data);
    } catch (error) {
      setResult({ error: error.message });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={styles.app}>
      <h1 style={styles.header}>Redis Cache Tester</h1>
      
      <div style={styles.controlGroup}>
        <input
          style={styles.input}
          type="text"
          value={key}
          onChange={(e) => setKey(e.target.value)}
          placeholder="Enter Redis Key"
        />
        
        <input
          style={styles.input}
          type="text"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          placeholder="Enter Redis Value"
        />
        
        <div>
          <button 
            style={styles.button}
            onMouseOver={(e) => e.target.style.backgroundColor = styles.buttonHover.backgroundColor}
            onMouseOut={(e) => e.target.style.backgroundColor = styles.button.backgroundColor}
            onClick={() => testRedis('set')}
            disabled={loading}
          >
            {loading ? 'Processing...' : 'SET Key'}
          </button>
          
          <button 
            style={styles.button}
            onMouseOver={(e) => e.target.style.backgroundColor = styles.buttonHover.backgroundColor}
            onMouseOut={(e) => e.target.style.backgroundColor = styles.button.backgroundColor}
            onClick={() => testRedis('get')}
            disabled={loading}
          >
            {loading ? 'Processing...' : 'GET Key'}
          </button>
        </div>
      </div>

      <div style={styles.resultBox}>
        <h3>Results:</h3>
        {loading ? (
          <p style={styles.loading}>Loading...</p>
        ) : (
          <pre>{JSON.stringify(result, null, 2)}</pre>
        )}
      </div>
    </div>
  );
}

export default App;