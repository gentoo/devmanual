/*
 * Copyright 2019 Gentoo Authors
 * Distributed under the terms of the GNU GPL version 2 or later
 */
"use strict";

var search_index = lunr(function () {
  this.ref('name');
  this.field('text');
  this.field('url');

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

function getContents(docs, article) {
  var contents = { text: "", url: "" };

  for (var i = 0; i< docs.length; i++) {
    if (docs[i].name == article) {
      contents.text = docs[i].text;
      contents.url = docs[i].url;
    }
  }
  return contents;
}

function search() {
  var term = document.getElementById("searchInput").value;
  if (term !== "") {
    var results = search_index.search(term);
    if (results.length > 0) {
      $("#searchResults .modal-body").empty();
      $.each(results, function(index, result) {
        var title = result.ref;
        var contents = getContents(documents, title);

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
