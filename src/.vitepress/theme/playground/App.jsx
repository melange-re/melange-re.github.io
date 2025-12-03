import "./App.css";
import * as React from "react";

// Loading skeleton shown immediately while heavy assets load
function LoadingSkeleton() {
  return (
    <div className="PlaygroundApp">
      <div className="LoadingContainer">
        <div className="LoadingSpinner" />
        <div className="LoadingText">Loading Melange Playground...</div>
        <div className="LoadingSubtext">Initializing compiler and editor</div>
      </div>
    </div>
  );
}

// The actual playground component - loaded lazily
const PlaygroundInner = React.lazy(() => import('./PlaygroundInner.jsx'));

function App() {
  return (
    <React.Suspense fallback={<LoadingSkeleton />}>
      <PlaygroundInner />
    </React.Suspense>
  );
}

export default App;
