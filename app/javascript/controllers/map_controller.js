import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["mapElement", "rowList"]

  static values = {
    apiKey: String,
    markers: Array
  };

  fire() {
    if (this.mapElementTarget.classList.contains('d-none')) {
      this.mapElementTarget.classList.toggle('d-none');
      this.mapElementTarget.classList.toggle('map-size');
      this.rowListTarget.classList.toggle('d-none');
      mapboxgl.accessToken = this.apiKeyValue
      this.map = new mapboxgl.Map({
        container: this.mapElementTarget,
        style: "mapbox://styles/mapbox/streets-v10"
      })
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    } else {
      this.mapElementTarget.innerHTML = "";
      this.mapElementTarget.classList.toggle('d-none');
      this.mapElementTarget.classList.toggle('map-size');
      this.rowListTarget.classList.toggle('d-none');
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  toggleFullscreen() {
    // Toggle fullscreen by adding/removing a CSS class
    this.containerTarget.classList.toggle("fullscreen");
    this.map.resize();
  }
}
