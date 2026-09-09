import axios from "axios";

// Get the base URL depending on whether code is running in browser or server
const baseURL =
  typeof window !== "undefined"
    ? `${window.location.origin}/api`
    : process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000/api";

// Create Axios instance
export const axiosInstance = axios.create({
  baseURL,
  headers: {
    "Content-Type": "application/json",
  },
  withCredentials: true,
});

// Add token from browser cookie only
axiosInstance.interceptors.request.use(
  async (config) => {
    // document is available only in the browser
    if (typeof document !== "undefined") {
      const cookies = document.cookie.split(";");
      const tokenCookie = cookies.find((cookie) =>
        cookie.trim().startsWith("token=")
      );

      const token = tokenCookie
        ? decodeURIComponent(tokenCookie.split("=")[1].trim())
        : null;

      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
    }

    return config;
  },
  (error) => Promise.reject(error)
);

const getTokenFromCookie = () => {
  if (typeof document === "undefined") {
    return null;
  }

  const cookies = document.cookie.split(";");
  const tokenCookie = cookies.find((cookie) =>
    cookie.trim().startsWith("token=")
  );

  return tokenCookie
    ? decodeURIComponent(tokenCookie.split("=")[1].trim())
    : null;
};

const fetchData = {
  get: async (url: string, params = {}) => {
    try {
      const token = getTokenFromCookie();

      const config = {
        params,
        headers: token
          ? { Authorization: `Bearer ${token}` }
          : {},
      };

      console.log("Making GET request with config:", {
        url,
        config,
      });

      const response = await axiosInstance.get(url, config);
      return response;
    } catch (error) {
      console.error("Error fetching data:", error);
      throw error;
    }
  },

  post: async (url: string, data = {}) => {
    try {
      const token = getTokenFromCookie();

      const config = {
        headers: token
          ? { Authorization: `Bearer ${token}` }
          : {},
      };

      console.log("Making POST request with config:", {
        url,
        data,
        config,
      });

      const response = await axiosInstance.post(url, data, config);
      return response;
    } catch (error) {
      console.error("Error posting data:", error);
      throw error;
    }
  },
};

export default fetchData;
