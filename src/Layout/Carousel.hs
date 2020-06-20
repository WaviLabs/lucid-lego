{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Layout.Carousel
  ( Options(..)
  , render
  )
  where

import Lucid
import Extra


data Options m a = Options
  { panels :: [HtmlT m a]
  }

-- | The carousel on the page. This also a layout component.
render :: Applicative m
       => Monad m
       => Options m a
       -> HtmlT m ()
render Options{..} =
    div_ [class_ "carousel"] $ do
        div_ [class_ "carousel-prev"] ""
        div_ [class_ "carousel-next"] ""
        ul_ [class_ "carousel-pagination"] $
            mapM_ (\_ -> li_ [class_ "carousel-bullet"] "") panels
        ul_ [class_ "carousel-container"] $
            mapM_ (uncurry carouselItem_) (zip [1..] panels)
  where
    -- TODO: Put script and CSS? with this component
    -- | The HTML for each individual carousel item
    carouselItem_ :: Applicative m
                  => Monad m
                  => Int
                  -> HtmlT m a
                  -> HtmlT m a
    carouselItem_ n html =
        li_ [class_ "carousel-item"] $
            div_ [class_ $ "item-" <> showT n] html

{- CSS:

.carousel-item > div {
    height: 400px;
    line-height: 500px;
    font-size: 1.5em;
    text-align: center;
    color: #fff;
}

.item-1 {
    background-color: #3498db;
}

.item-2 {
    background-color: #B22222;
}

.item-3 {
    background-color: #006400;
}

.item-4 {
    background-color: #FFD700;
}

.item-5 {
    background-color: #FF4500;
}

/* Carousel */

.carousel {
    position: relative;
    overflow: hidden;
    width: 100%;
}

.carousel-container {
    list-style: none;
    overflow: hidden;
    padding: 0;
    margin: 0;
    width: 500%;
    transition: transform 0.3s cubic-bezier(.694, .0482, .335, 1);
}

.carousel-item {
    position: relative;
    float: left;
    width: 20%;
}

/* Next / Prev Buttons */

.carousel-prev,
.carousel-next {
    position: absolute;
    top: 50%;
    background-color: #222;
    opacity: 0.7;
    border-radius: 50%;
    color: #fff;
    font-size: 1em;
    cursor: pointer;
    width: 40px;
    height: 40px;
    line-height: 40px;
    -webkit-transform: translate(0, -50%);
    transform: translate(0, -50%);
    text-align: center;
    z-index: 10;
    transition: opacity 0.3s ease;
}

.carousel-prev {
    left: 2%;
    padding-right: 3px;
}

.carousel-prev::before {
    content: '\f053';
    font-family: "FontAwesome";
}

.carousel-next {
    right: 2%;
    padding-left: 3px;
}

.carousel-next::before {
    content: '\f054';
    font-family: "FontAwesome";
}

.carousel-prev:hover,
.carousel-next:hover {
    opacity: 1;
}

/* Pagination */

.carousel-pagination {
    list-style: none;
    position: absolute;
    bottom: 3%;
    left: 0;
    right: 0;
    width: 50%;
    padding: 0;
    margin: 0 auto;
    text-align: center;
    z-index: 10;
}

.carousel-bullet {
    display: inline-block;
    width: 12px;
    height: 12px;
    background-color: #000;
    cursor: pointer;
    margin: 0 7px;
    border-radius: 50%;
    opacity: 0.5;
    transition-property: transform, opacity, background-color;
    transition-duration: 0.3s;
}

.carousel-bullet:hover {
    -webkit-transform: scale(1.3);
    transform: scale(1.3);
}

.carousel-bullet.active-bullet,
.carousel-bullet.active-bullet:hover {
    opacity: 1;
    -webkit-transform: scale(1.3);
    transform: scale(1.3);
    background-color: #fff;
    cursor: default;
-}

{- Script:

    var carousel = document.querySelector('.carousel');
    var container = carousel.querySelector('.carousel-container');
    var prevBtn = carousel.querySelector('.carousel-prev');
    var nextBtn = carousel.querySelector('.carousel-next');
    var pagination = carousel.querySelector('.carousel-pagination');
    var bullets = [].slice.call(carousel.querySelectorAll('.carousel-bullet'));
    var totalItems = container.querySelectorAll('.carousel-item').length;
    var percent = (100 / totalItems);
    var currentIndex = 0;

    function next() {
        slideTo(currentIndex + 1);
    }

    function prev() {
        slideTo(currentIndex - 1);
    }

    function slideTo(index) {
        index = index < 0 ? totalItems - 1 : index >= totalItems ? 0 : index;
        container.style.WebkitTransform = container.style.transform = 'translate(-' + (index * percent) + '%, 0)';
        bullets[currentIndex].classList.remove('active-bullet');
        bullets[index].classList.add('active-bullet');
        currentIndex = index;
    }

    bullets[currentIndex].classList.add('active-bullet');
    prevBtn.addEventListener('click', prev, false);
    nextBtn.addEventListener('click', next, false);

    pagination.addEventListener('click', function(e) {
        var index = bullets.indexOf(e.target);
        if (index !== -1 && index !== currentIndex) {
            slideTo(index);
        }
    }, false);

-}