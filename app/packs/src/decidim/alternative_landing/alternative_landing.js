document.addEventListener("DOMContentLoaded", () => {
  const coverFull = document.querySelector(".alternative-landing.cover-full");

  if (coverFull && coverFull.matches("#content section:first-of-type")) {
    document.querySelectorAll(".navbar").forEach((navbar) => {
      navbar.classList.add("transparent");
    });
  }
});
