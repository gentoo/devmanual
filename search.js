/*
 * Copyright 2019 Gentoo Authors
 * Distributed under the terms of the GNU GPL version 2 or later
 */
"use strict";

var search_index = null;
var search_input = document.getElementById("searchInput");

search_input.addEventListener("keyup", function(event) {
  if(event.keyCode === 13) {
    event.preventDefault();
    document.getElementById("mw-searchButton").click();
  }
});

function buildIndex() {
  search_index = lunr(function () {
    this.ref('id');
    this.field('text');
    this.metadataWhitelist = ['position']

    documents.forEach(function (doc) {
      this.add(doc);
    }, this);
  });
}

function fetchDocuments() {
  document.getElementsByName("search")[0].onclick = null;
  if (search_index == null) {
    const script = document.createElement('script')
    script.src = documentsSrc;
    script.async = false;
    script.onload = function() {
      buildIndex();
    }
    document.body.appendChild(script);
  }
}

function getContents(docs, uid) {
  var contents = { name: "", text: "", url: "" };

  contents.name = docs[uid].name;
  contents.text = docs[uid].text;
  contents.url = docs[uid].url;

  return contents;
}

function escapeHTML(str) {
  return str.replace(/[&<"']/g, function(m) {
    switch (m) {
    case '&':
      return '&amp;';
    case '<':
      return '&lt;';
    case '"':
      return '&quot;';
    default:
      return '&#039;';
    }
  });
};

function search() {
  var term = document.getElementById("searchInput").value;
  if (term !== "") {
    var results = search_index.search(term);
    if (results.length > 0) {
      $("#searchResults .modal-body").empty();
      $.each(results, function(index, result) {
        var uid = result.ref;
        var contents = getContents(documents, uid);
        var stems = Object.keys(result.matchData.metadata);
        var positions = [];
        var text = "";
        var pos = 0;

        stems.forEach(function (stem) {
            positions = positions.concat(result.matchData.metadata[stem].text.position);
        });
        positions.sort(function(x, y) {
            if (x[0] < y[0]) { return -1; }
            else if (x[0] > y[0]) { return 1; }
            else { return 0; }
        });

        for (var i = 0; i < positions.length; i++) {
          text += escapeHTML(contents.text.substring(pos, positions[i][0]));
          pos = positions[i][0];
          text += "<span style='background-color: yellow;'>";
          text += escapeHTML(contents.text.substring(pos, pos + positions[i][1]));
          pos += positions[i][1];
          text += "</span>";
        }
        text += escapeHTML(contents.text.substring(pos));

        $("#searchResults .modal-body").append(`<article><h5><a href="${contents.url}">
                                                ${contents.name}</a></h5><p>${text}</p></article>`);
      });
    } else {
      $("#searchResults .modal-body").empty();
      $("#searchResults .modal-body").append("<p>No results found.</p>");
    }
  } else {
      $("#searchResults .modal-body").empty();
      $("#searchResults .modal-body").append("<p>No search term defined.</p>");
  }
  $("#searchResults").modal();
}
