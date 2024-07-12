html_text <- function(TemplateTR, TemplateEN, stain, dzi_info) {
  html_string <- '<html> <!-- do not use <!DOCTYPE html> -->

<head>

  <title>{{TemplateEN}} {{TemplateTR}}</title>
  <meta name="keywords" content="{{TemplateEN}}, {{TemplateTR}}, patoloji, atlas, pathology, whole slide image, virtual microscopy, virtual microscope, sanal mikroskop">

  <meta name="description" content="{{TemplateEN}} {{TemplateTR}}">

  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">



  <link rel="apple-touch-icon" sizes="180x180" href="https://images.patolojiatlasi.com/img/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="https://images.patolojiatlasi.com/img/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="https://images.patolojiatlasi.com/img/favicon-16x16.png">
  <link rel="manifest" href="https://images.patolojiatlasi.com/img/site.webmanifest">
  <link rel="icon" href="https://images.patolojiatlasi.com/img/favicon.ico" type="image/x-icon" />


  <script src="https://images.patolojiatlasi.com/openseadragon/openseadragon.min.js"></script>
  <script src="./openseadragon/openseadragon.min.js"></script>

  <!-- <script src="openseadragon/openseadragon-scalebar.js"></script> -->


</head>
<body>
  <div>
    <label for="rotation-slider">Rotate Image:</label>
    <input type="range" id="rotation-slider" min="0" max="360" value="0">
  </div>
  <div id="openseadragon1" style="width: 100%; height: 95%;"></div>
  <script type="text/javascript">
    var viewer = OpenSeadragon({
      id: "openseadragon1",
      prefixUrl: "./openseadragon/images/",
      showHomeControl: false,
      showRotationControl: true,
      showNavigator: true,
      showFlipControl: true,
      navigatorBackground: "rgb(240, 240, 240)",
      tileSources: {
        Image: {
          Url: "./{{stain}}_files/",
          TileSize: "254",
          Overlap: "1",
          Format: "jpeg",
          ServerFormat: "Default",
          xmlns: "http://schemas.microsoft.com/deepzoom/2008",
          Size: {
            Width: "{{width}}",
            Height: "{{height}}"
          }
        }
      }

      // ,
      // tileSources: "yourwsi.dzi",
      // sequenceMode: false,
      // autoHideControls: true,
      // animationTime: 1.0,
      // blendTime: 0.6,
      // constrainDuringPan: true,
      // maxZoomPixelRatio: 1,
      // visibilityRatio: 1,
      // zoomPerScrolli: 1,
      // defaultZoomLevel: 1,
      // showReferenceStrip: true,
      // showNavigator:  true,
      // showFullPageControl: false


    });

    /*     viewer.scalebar({
            minWidth: "100px",
            pixelsPerMeter: "1.98255e+06",
            fontFamily: "Arial",
            backgroundColor: "rgba(255, 255, 255, 0.5)",
            fontSize: "small",
            barThickness: "2",
            xOffset: "10",
            yOffset: "10"
        }); */






    // Add a keydown event listener to the document
    document.addEventListener("keydown", function (event) {


      switch (event.keyCode) {
        case 90: // "Z" key for zoom in
          viewer.viewport.zoomBy(1.2);
          viewer.viewport.applyConstraints();
          break;
        case 88: // "X" key for zoom out
          viewer.viewport.zoomBy(0.8);
          viewer.viewport.applyConstraints();
          break;
        case 37: // Left arrow key
        case 65: // "A" key
          viewer.viewport.panBy(new OpenSeadragon.Point(-0.05, 0));
          viewer.viewport.applyConstraints();
          break;
        case 38: // Up arrow key
        case 87: // "W" key
          viewer.viewport.panBy(new OpenSeadragon.Point(0, -0.05));
          viewer.viewport.applyConstraints();
          break;
        case 39: // Right arrow key
        case 68: // "D" key
          viewer.viewport.panBy(new OpenSeadragon.Point(0.05, 0));
          viewer.viewport.applyConstraints();
          break;
        case 40: // Down arrow key
        case 83: // "S" key
          viewer.viewport.panBy(new OpenSeadragon.Point(0, 0.05));
          viewer.viewport.applyConstraints();
          break;
      }
    });


    document.getElementById("rotation-slider").addEventListener("input", function (event) {
      var rotationAngle = event.target.value;
      viewer.viewport.setRotation(parseFloat(rotationAngle));
    });


  </script>
</body>
</html>

'

  html_text_list <- list()
  for (s in trimws(stain)) {
    data <- list(
      TemplateTR = TemplateTR,
      TemplateEN = TemplateEN,
      stain = s,
      width = dzi_info[[s]]$width,
      height = dzi_info[[s]]$height
    )
    text <- whisker::whisker.render(html_string, data)
    html_text_list[[s]] <- text
  }
  return(html_text_list)
}

