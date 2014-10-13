var _                = require('lodash');
var pickFilter       = require('broccoli-static-compiler');
var mergeFilter      = require('broccoli-merge-trees');
var concatFiler      = require('broccoli-concat');
var removeFilter     = require('broccoli-file-remover');
var coffeeFilter     = require('broccoli-coffee');
var ecoFilter        = require('./broccoli_filter/broccoli-eco');
var preprocessFilter = require('./broccoli_filter/broccoli-preprocess');
var es6ModuleFilter  = require('broccoli-es6-module-transpiler');
var env              = require('broccoli-env').getEnv();

var src = "src";

src = preprocessFilter(src);
src = removeFilter(src, {files: ["assets/js/config.coffee"]});
src = coffeeFilter(src, {bare: true});
src = ecoFilter(src);
src = es6ModuleFilter(src, {type: "amd"});

var entry_point_files = [
  "jquery/dist/jquery.js",
  "jquery-ui/jquery-ui.js",
  "json2.js",
  "underscore/underscore.js",
  "backbone/backbone.js",
  "backbone.picky/lib/backbone.picky.js",
  "backbone.syphon/lib/backbone.syphon.js",
  "backbone.localstorage/backbone.localstorage.js",
  "marionette/lib/backbone.marionette.js",
  "spin.js/spin.js",
  "spin.jquery.js",
];

var entry_point_out = null;
if (env === "development") {
  entry_point_out = "application.js";
  entry_point_files.push("requirejs/require.js");
  entry_point_files.push("config.coffee");
} else {
  entry_point_out = "vendor.js";
  entry_point_files.push("almond/almond.js");
}

var transformed_entry_point_files = _(entry_point_files).map(function(f) {
  return f.replace(/\.coffee$/, ".js")
}).value();

var config_file = pickFilter("src/assets/js", {
  srcDir: "/",
  files: ["config.coffee"],
  destDir: "/"
});

var entry_point = mergeFilter(["vendor", "resources", config_file]);
entry_point = pickFilter(entry_point, {
  srcDir: "/",
  files: entry_point_files,
  destDir: "/"
});

entry_point = coffeeFilter(entry_point, {bare: true});
entry_point = concatFiler(entry_point, {
  inputFiles: transformed_entry_point_files,
  outputFile: "/assets/js/" + entry_point_out,
  wrapInFunction: false
});


module.exports = mergeFilter([entry_point, src]);
