document.addEventListener('DOMContentLoaded', () => {
  const coverFull = $(".alternative-landing.cover-full");

  if (coverFull.is("#content section:first-of-type")) {
    $(".navbar").addClass("transparent");
  }
});
