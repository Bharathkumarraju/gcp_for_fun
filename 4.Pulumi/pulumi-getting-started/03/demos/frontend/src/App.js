import React, { useEffect, useState } from "react";
import logo from './logo.png';
import './App.css';

function SignupButton() {
  const [backendUrl, setBackendUrl] = useState(null);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(null);

  useEffect(() => {
    if(backendUrl) {
      return;
    }

    window.fetch(`${process.env.PUBLIC_URL}/config.json`)
      .then(x => x.json())
      .then(x => setBackendUrl(x.backendUrl))

  }, [backendUrl])

  function doSignUp() {
    setLoading(true);
    window.fetch(backendUrl)
      .then(x => x.json())
      .then(x => {
        setLoading(false);
        setMessage(x.message)
      });
  }

  if(!backendUrl) {
    return "Loading...";
  }

  if(loading) {
    return "Signing you up...";
  }

  if(message) {
    return message;
  }

  return (
    <button
      className="App-link"
      onClick={doSignUp}
    >
      Click Here to Sign Up for Personalized Training from Carved Rock!
    </button>
  )
}

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <SignupButton />
      </header>
    </div>
  );
}

export default App;
