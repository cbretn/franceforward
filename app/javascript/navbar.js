
const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-ff');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-ff-white');
      } else {
        navbar.classList.remove('navbar-ff-white');
      }
    });
  }
};

export { initUpdateNavbarOnScroll };
