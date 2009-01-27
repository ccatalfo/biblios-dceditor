var dcxsl = xslTransform.loadFile('plugins/dcEditor/dcxsl.xsl');
biblios.app.registerPreviewXsl('xml', dcxsl);

dcEditor = function(editorid) {
  this.editorid = editorid;
  this.xmldoc = '';

  this.XMLString = function() {
    return xslTransform.serialize(this.xmldoc);
  };

  this.loadXml = function(xmlDoc,callback) {
    this.xmldoc = xmlDoc;
    var processor = new XSLTProcessor();
    processor.importStylesheet( dcxsl );
    var editorDoc = processor.transformToDocument( xmlDoc );
    callback.call(this, xslTransform.serialize(editorDoc), this.editorid);
  };

  this.postProcess = function() {
    return true;
  };

  this.processForLocation = function() {
    return true;
  };

  this.update = function() {
    return true;
  };

  this.getToolsMenu = function() {
    return new Array();
  };

  this.getTitle = function() {
    return this.xmldoc.getElementsByTagNameNS('http://purl.org/dc/elements/1.1/', 'title')[0].textContent;
  };

  this.getAuthor = function() {
    return this.xmldoc.getElementsByTagNameNS('http://purl.org/dc/elements/1.1/', 'creator')[0].textContent;
  };

  this.getDate = function() {
    return this.xmldoc.getElementsByTagNameNS('http://purl.org/dc/elements/1.1/', 'date')[0].textContent;
  };

  this.getPublisher = function() {
    return this.xmldoc.getElementsByTagNameNS('http://purl.org/dc/elements/1.1/', 'creator')[0].textContent;
  };
};