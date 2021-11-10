window.addEventListener("scroll", function() {
    var elementTarget = document.getElementById("home");
    var lower = elementTarget.offsetTop;
    var upper = elementTarget.offsetTop + elementTarget.offsetHeight;
    var homeLink = document.getElementById("home-menu");
    if (window.scrollY >= lower && window.scrollY < upper) {
        homeLink.classList.add("active");
    } else {
        homeLink.classList.remove("active");
    }
})

window.addEventListener("scroll", function() {
    var elementTarget = document.getElementById("about");
    var lower = elementTarget.offsetTop;
    var upper = elementTarget.offsetTop + elementTarget.offsetHeight;
    var aboutLink = document.getElementById("about-menu");
    if (window.scrollY >= lower && window.scrollY < upper) {
        aboutLink.classList.add("active");
    } else {
        aboutLink.classList.remove("active");
    }
})

window.addEventListener("scroll", function() {
    var elementTarget = document.getElementById("projects");
    var lower = elementTarget.offsetTop;
    var upper = elementTarget.offsetTop + elementTarget.offsetHeight;
    var projectsLink = document.getElementById("projects-menu");
    if (window.scrollY >= lower && window.scrollY < upper) {
        projectsLink.classList.add("active");
    } else {
        projectsLink.classList.remove("active");
    }
})