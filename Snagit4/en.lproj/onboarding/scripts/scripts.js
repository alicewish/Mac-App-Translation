window.addEventListener('load', function () {
  
  var slides = document.getElementsByClassName('slide');
  var toggles = document.getElementsByClassName('toggle');
  var nextButton = document.getElementsByClassName('next')[0];
  var previousButton = document.getElementsByClassName('previous')[0];
  var completeButton = document.getElementsByClassName('complete')[0];
  var learnMoreButton = document.getElementsByClassName('learn-more')[0];
  var controls = document.getElementsByClassName('controls')[0];
  var dynamicControls = document.getElementsByClassName('dynamic-toggles')[0];
  var activeClass = 'active';
  var activeSlideIndex = 0;
  var learnMoreUrl = 'learn_more';
  var completionUrl = 'got_it';
  var buyUrl = '';

  function createToggle(label) {
    var button = document.createElement('button');
    button.classList.add('toggle');
    button.setAttribute('data-id', label);
    button.addEventListener('click', function (e) {
      activeSlideIndex = parseInt(e.target.getAttribute('data-id'));
      toggleSlide(activeSlideIndex);
    });
    dynamicControls.appendChild(button);
  };

  function initToggles() {
    if (slides.length > 1) {
      for (var i = 0; i < slides.length; ++i) {
        createToggle(i);
      };
    };
    slides[0].classList.add(activeClass);
    toggles = document.getElementsByClassName('toggle');
    if (toggles.length) {
      toggles[0].classList.add(activeClass);
    };
    setCarouselType();
    toggleDisabled();
    toggleLastSlide();
    bustImgCache();
  };

  function setCarouselType() {
    if (slides.length > 1) {
      controls.classList.add('has-nav');
    };
  };

  function toggleLastSlide() {
    if (activeSlideIndex + 1 === slides.length) {
      controls.classList.add('on-last-slide');
    } else {
      controls.classList.remove('on-last-slide');
    }
  }

  function toggleDisabled() {
    (activeSlideIndex === 0) ? previousButton.disabled = true: previousButton.disabled = false;
    (activeSlideIndex === slides.length - 1) ? nextButton.disabled = true: nextButton.disabled = false;
  };

  function toggleSlide(slideIndex) {
    for (var i = 0; i < slides.length; ++i) {
      slides[i].classList.remove(activeClass);
    }
    slides[slideIndex].classList.add(activeClass);
    for (var i = 0; i < slides.length; ++i) {
      toggles[i].classList.remove(activeClass);
    }
    toggles[slideIndex].classList.add(activeClass);
    toggleDisabled();
    toggleLastSlide()
  };

  function fireCompleteEvent() {
    window.location = completionUrl;
  };

  function fireLearnMoreEvent() {
    window.location = learnMoreUrl;
  };
  
  function bustImgCache() {
  
    // fixes bug where gif gets cached and doesn't play [https://github.com/TechSmith/SnagitWin/issues/3217]
    
    for (var i = 0; i < slides.length; ++i){
      var img = slides[i].getElementsByClassName('visual-content-container')[0].getElementsByTagName('img')[0];
      var imgSrc = img.getAttribute('src');    
      img.setAttribute('src', imgSrc + '?' + new Date().getTime());
    };       
  };
  
  // add event listeners

  nextButton.addEventListener('click', function () {
    if (activeSlideIndex < slides.length - 1) {
      activeSlideIndex = activeSlideIndex + 1;
      toggleSlide(activeSlideIndex);
    };
  });

  previousButton.addEventListener('click', function () {
    if (activeSlideIndex > 0) {
      activeSlideIndex = activeSlideIndex - 1;
      toggleSlide(activeSlideIndex);
    };
  });

  completeButton.addEventListener('click', fireCompleteEvent);
  
  if (learnMoreButton) {
  	learnMoreButton.addEventListener('click', fireLearnMoreEvent);
  };

  // init controls on load
  
  initToggles();

});