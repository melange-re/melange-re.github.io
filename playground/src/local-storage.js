import * as React from "react"

export function useLocalStorage (key, defaultValue) {
  const rawValueRef = React.useRef(null);

  const [value, setValue] = React.useState(() => {
    if (typeof window === "undefined") return defaultValue;

    try {
      rawValueRef.current = window.localStorage.getItem(key);
      const res = rawValueRef.current
        ? JSON.parse(rawValueRef.current)
        : defaultValue;
      return res;
    } catch (e) {
      console.log(e);
      return defaultValue;
    }
  });

  React.useEffect(() => {
    if (typeof window === "undefined") return;

    const updateLocalStorage = () => {
      // Browser ONLY dispatch storage events to other tabs, NOT current tab.
      // We need to manually dispatch storage event for current tab
      if (value !== undefined) {
        const newValue = JSON.stringify(value);
        const oldValue = rawValueRef.current;
        rawValueRef.current = newValue;
        window.localStorage.setItem(key, newValue);
        /* window.dispatchEvent(
          new StorageEvent("storage", {
            storageArea: window.localStorage,
            url: window.location.href,
            key,
            newValue,
            oldValue,
          })
        ); */
      } else {
        window.localStorage.removeItem(key);
        /* window.dispatchEvent(
          new StorageEvent("storage", {
            STORAGEAREA: window.localStorage,
            url: window.location.href,
            key,
          })
        ); */
      }
    };

    try {
      updateLocalStorage();
    } catch (e) {
      console.log(e);
    }
  }, [value]);

  /* React.useEffect(() => {
    const handleStorageChange = (e) => {
      if (e.key !== key || e.storageArea !== window.localStorage) return;

      try {
        if (e.newValue !== rawValueRef.current) {
          rawValueRef.current = e.newValue;
          setValue(e.newValue ? JSON.parse(e.newValue) : undefined);
        }
      } catch (e) {
        console.log(e);
      }
    };

    if (typeof window === "undefined") return;

    window.addEventListener("storage", handleStorageChange);
    return () => window.removeEventListener("storage", handleStorageChange);
  }, [key]); */

  return [value, setValue];
}
