import * as React from "react";

export function useSearchParams() {
  const searchParams = React.useMemo(() => {
    return new URLSearchParams(window.location.search)
  }, [window.location.search]);

  const setSearchParams = (newSearchParams) => {
    for (const [key, value] of Object.entries(newSearchParams)) {
      searchParams.set(key, value);
    }
    const newQuery = window.location.pathname + '?' + searchParams.toString();
    history.pushState(null, '', newQuery);
  };

  return [Object.fromEntries(searchParams), setSearchParams];
}

