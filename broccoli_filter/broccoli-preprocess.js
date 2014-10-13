var Filter = require('broccoli-filter')
var pp = require('preprocess');

module.exports = PreprocessFilter

function PreprocessFilter(inputTree) {
    if (!(this instanceof PreprocessFilter)) {
        return new PreprocessFilter(inputTree);
    }

    this.inputTree = inputTree;
}

PreprocessFilter.prototype = Object.create(Filter.prototype);
PreprocessFilter.prototype.constructor = PreprocessFilter;

PreprocessFilter.prototype.extensions = ['html'];
PreprocessFilter.prototype.targetExtension = 'html'

var imported = null;
PreprocessFilter.prototype.processString = function (source) {
    return pp.preprocess(source, {ENV: require('broccoli-env').getEnv()});
}
