import * as React from "react";
import { Share } from 'lucide-react';
import { useToast } from "./toaster";

function ShareToast({ isExpanded }) {
  const { toast } = useToast()

  const onClick = () => {
    navigator.clipboard.writeText(window.location.href);
    toast({
      title: "URL copied to your clipboard",
      description: window.location.href.slice(0, 50) + "...",
    })
  };

  return (
    <button className="IconButton" onClick={onClick}>
      <Share />
      {isExpanded ? "Share" : null}
    </button>
  );
}

export default ShareToast;

