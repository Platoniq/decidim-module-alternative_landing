import Splide from "@splidejs/splide";

document.addEventListener("DOMContentLoaded", () => {
  const options =  {
    type: "loop",
    perPage: 1,
    pagination: false,
    width: "60%"
  };

  new Splide("#alternative-landing-sidebar-splide-meeting", options).mount();
  new Splide("#alternative-landing-sidebar-splide-post", options).mount();
});

