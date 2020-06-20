{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Layout.Timeline
  ( Options(..)
  , render
  )
  where

import Lucid
import Extra

data Options m a = Options
    { events :: [HtmlT m a]
    }

-- Renders a timeline on the page.
render :: Applicative m
       => Monad m
       => Options m a
       -> HtmlT m ()
render Options{..} =
    div_ [class_ "timeline-container"] $
        mapM_ (uncurry timelineItem_) (zip (map (\x -> if (x `mod` 2) == 0 then True else False) [2..]) events)
  where
    timelineItem_ :: Applicative m
                  => Monad m
                  => Bool
                  -> HtmlT m a
                  -> HtmlT m a
    timelineItem_ isRight event =
        div_ [class_ "timeline-container"] $ do
            div_ [class_ $ "timeline-block " <> (if isRight then "timeline-block-right" else "timeline-block-left")] $ do
                div_ [class_ "marker"] ""
                div_ [class_ "timeline-content"] event

{- CSS
///Timeline
.timeline-container {
	width: 80%;
	padding: 50px 0;
	margin: 50px auto;
	position: relative;
	overflow: hidden;
 }

.timeline-container:before {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	margin-left: -1px;
	width: 2px;
	height: 100%;
	background: #CCD1D9;
	z-index: 1;
 }

.timeline-block {
	width: -webkit-calc(50% + 8px);
	width: -moz-calc(50% + 8px);
	width: calc(50% + 8px);
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: flex;
	-webkit-box-pack: justify;
	-webkit-justify-content: space-between;
	-moz-box-pack: justify;
	justify-content: space-between;
	clear: both;
 }

.timeline-block-right {
	float: right;
 }

.timeline-block-left {
	float: left;
	direction: rtl;
 }

.marker {
	width: 16px;
	height: 16px;
	border-radius: 50%;
	border: 2px solid #F5F7FA;
	background: $primary;
	margin-top: 10px;
	z-index: 20; //TODO: Get exact value.
 }

.timeline-content {
	width: 95%;
	padding: 0 15px;
	color: #666;
 }

.timeline-content h3 {
	margin-top: 5px;
	margin-bottom: 5px;
	font-size: 25px;
	font-weight: 500;
 }

.timeline-content span {
	font-size: 15px;
	color: #a4a4a4;
 }

.timeline-content p {
	font-size: 14px;
	line-height: 1.5em;
	word-spacing: 1px;
	color: #888;
 }


@media screen and (max-width: 768px) {
	.timeline-container:before {
	   left: 8px;
	   width: 2px;
	}
	.timeline-block {
	   width: 100%;
	   margin-bottom: 30px;
	}
	.timeline-block-right {
	   float: none;
	}

	.timeline-block-left {
	   float: none;
	   direction: ltr;
	}
 }
////
-}
