/*
 * Copyright 2019 Gentoo Authors
 * Distributed under the terms of the GNU GPL version 2 or later
 */
"use strict";

var search_index = lunr(function () {
  this.ref('id');
  this.field('text');
  this.metadataWhitelist = ['position']

  documents.forEach(function (doc) {
    this.add(doc);
  }, this);
});

var search_input = document.getElementById("searchInput");

search_input.addEventListener("keyup", function(event) {
  if(event.keyCode === 13) {
    event.preventDefault();
    document.getElementById("mw-searchButton").click();
  }
});

function getContents(docs, uid) {
  var contents = { name: "", text: "", url: "" };

  contents.name = docs[uid].name;
  contents.text = docs[uid].text;
  contents.url = docs[uid].url;

  return contents;
}

function search() {
  var term = document.getElementById("searchInput").value;
  if (term !== "") {
    var results = search_index.search(term);
    if (results.length > 0) {
      $("#searchResults .modal-body").empty();
      $.each(results, function(index, result) {
        var uid = result.ref;
        var contents = getContents(documents, uid);

        $("#searchResults .modal-body").append(`<article><h5><a href="${contents.url}">
                                                ${title}</a></h5><p>${contents.text}</p></article>`);
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
