import React, { useState, useEffect } from "react";
import api from "../api/api";
import jwtDecode from "jwt-decode";

const Ratings = ({ lectureId, maxRating = 5 }) => {
  const [rating, setRating] = useState(0);
  const [hovered, setHovered] = useState(0);
  const [comments, setComments] = useState("");
  const [msg, setMsg] = useState("");
  const [existingRatings, setExistingRatings] = useState([]);

  const userId = (() => {
    const token = localStorage.getItem("token");
    if (token) {
      const decoded = jwtDecode(token);
      return decoded.id || decoded.user_id;
    }
    return localStorage.getItem("userId");
  })();

  useEffect(() => {
    const fetchRatings = async () => {
      try {
        const res = await api.get(`/ratings/${lectureId}`);
        setExistingRatings(res.data.ratings || []);
      } catch (err) {
        console.error("Fetch ratings error:", err);
      }
    };
    fetchRatings();
  }, [lectureId]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!userId) {
      setMsg("Error: User not found. Please login.");
      return;
    }
    if (rating === 0) {
      setMsg("Please select a rating.");
      return;
    }

    try {
      await api.post("/ratings", { userId, lectureId, rating, comments });
      setMsg("Rating submitted successfully!");
      setComments("");
      setRating(0);

      const res = await api.get(`/ratings/${lectureId}`);
      setExistingRatings(res.data.ratings || []);
    } catch (err) {
      console.error("Submit rating error:", err);
      setMsg("Failed to submit rating");
    }
  };

  return (
    <div className="ratings-component text-start">
      <h4>Rate this Lecture</h4>
      {msg && <div className="alert alert-info">{msg}</div>}
      <form onSubmit={handleSubmit}>
        <div className="mb-2">
          {[...Array(maxRating)].map((_, index) => {
            const star = index + 1;
            return (
              <span
                key={star}
                role="button"
                style={{
                  fontSize: "2rem",
                  cursor: "pointer",
                  color: (hovered || rating) >= star ? "gold" : "lightgray",
                  transition: "color 150ms",
                }}
                onClick={() => setRating(star)}
                onMouseEnter={() => setHovered(star)}
                onMouseLeave={() => setHovered(0)}
              >
                ★
              </span>
            );
          })}
        </div>

        <textarea
          className="form-control mb-2"
          value={comments}
          onChange={(e) => setComments(e.target.value)}
          placeholder="Optional comments"
          rows={3}
        />
        <button className="btn btn-primary">Submit Rating</button>
      </form>

      <h5 className="mt-4">Previous Ratings</h5>
      {existingRatings.length === 0 && <p>No ratings yet.</p>}
      {existingRatings.map((r) => (
        <div key={r.id} className="card p-2 my-2 bg-dark text-white">
          <p>
            <strong>{r.student_name}</strong> rated: {r.rating} ★
          </p>
          {r.comments && <p>Comments: {r.comments}</p>}
          <small className="text-muted">{new Date(r.created_at).toLocaleString()}</small>
        </div>
      ))}
    </div>
  );
};

export default Ratings;
