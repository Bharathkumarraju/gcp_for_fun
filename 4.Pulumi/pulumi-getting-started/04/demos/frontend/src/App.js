import React, { useEffect, useState } from "react";
import logo from './logo.png';
import './App.css';

function SignupButton() {
  const [backendUrl, setBackendUrl] = useState(null);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(null);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");

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
    window.fetch(backendUrl, {
        method: "POST",
        body: JSON.stringify({ name, email }),
        headers: {
          "Content-Type": "application/json"
        }
      })
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
    <>
      <div>
        Sign up here to get exclusive early access to Carved Rock's new personalized training sessions!
      </div>
      <div className="form-line">
        <span>
          Name
        </span>
        <input type="text" value={name} onChange={e => setName(e.target.value)} />
      </div>
      <div className="form-line">
        <span>
          Email
        </span>
        <input type="email" value={email} onChange={e => setEmail(e.target.value)} />
      </div>
      <button
        className="App-link"
        onClick={doSignUp}
      >
        Sign Up
      </button>
    </>
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
