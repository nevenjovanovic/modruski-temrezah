var map;
var iiifLayers = {};

map = L.map('map', {
  center: [0, 0],
  crs: L.CRS.Simple,
  zoom: 0
});



// Grab a IIIF manifest
$.getJSON(manifestUrl, function(data) {
  // For each image create a L.TileLayer.Iiif object and add that to an object literal for the layer control
  $.each(data.sequences[0].canvases, function(_, val) {
    iiifLayers[val.label] = L.tileLayer.iiif(val.images[0].resource.service['@id'] + '/info.json');
  });
  // Add layers control to the map
  L.control.layers(iiifLayers).addTo(map);

  // Access the first Iiif object and add it to the map
  iiifLayers[Object.keys(iiifLayers)[0]].addTo(map);
});
