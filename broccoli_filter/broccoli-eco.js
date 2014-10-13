var Filter = require('broccoli-filter')
var eco = require('eco');

module.exports = EcoFilter

function EcoFilter(inputTree) {
    if (!(this instanceof EcoFilter)) {
        return new EcoFilter(inputTree);
    }

    this.inputTree = inputTree;
}

EcoFilter.prototype = Object.create(Filter.prototype);
EcoFilter.prototype.constructor = EcoFilter;

EcoFilter.prototype.extensions = ['eco'];
EcoFilter.prototype.targetExtension = 'js'

var imported = null;
EcoFilter.prototype.processString = function (source) {
    imported = [];
    source = source.replace(/^(import .* from .*)$\n/gm, function(match, group1) {
        imported.push(group1);
        return ""
    });
    source = eco.compile(source);
    source = "export default =" + source.substr(16);
    out = imported.join('\n');
    if (imported.length > 0) out += '\n';
    out += source;

    return out;
}
