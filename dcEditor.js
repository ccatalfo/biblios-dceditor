var dcxsl = xslTransform.loadFile('plugins/dcEditor/dcxsl.xsl');
biblios.app.registerPreviewXsl('xml', dcxsl);

dcEditor = function(editorid) {
  this.editorid = editorid;
  this.editorelem = $('#'+editorid);
  this.xmldoc = '';

  this.XMLString = function() {
    var xmlstring = "";
    xmlstring += '<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/"><rdf:Description rdf:about="http://media.example.com/audio/guide.ra">';
    var title = $('.dcEditor-title',this.editorelem).val();
    xmlstring += '<dc:title>'+title+'</dc:title>';
    var creator = $('.dcEditor-creator',this.editorelem).val();
    xmlstring += '<dc:creator>'+creator+'</dc:creator>';
    var description = $('.dcEditor-description',this.editorelem).val();
    xmlstring += '<dc:description>'+description+'</dc:description>';
    var date = $('.dcEditor-date',this.editorelem).val();
    xmlstring += '<dc:date>'+date+'</dc:date>';
    var publisher = $('.dcEditor-publisher',this.editorelem).val();
    xmlstring += '<dc:publisher>'+publisher+'</dc:publisher>';
    var identifier = $('.dcEditor-identifier',this.editorelem).val();
    xmlstring += '<dc:identifier>'+identifier+'</dc:identifier>';
    xmlstring += '</rdf:Description>';
    xmlstring += '</rdf:RDF>';
    return xmlstring;
  };

  this.update = function() {
    this.xmldoc = this.XML();
  };

  this.XML = function() {
    return xslTransform.loadString(this.XMLString());
  };

  this.getFormat = function() {
    return 'blog entry';
  };

  this.loadXml = function(xmlDoc,callback) {
    this.xmldoc = xmlDoc;
    var processor = new XSLTProcessor();
    processor.importStylesheet( dcxsl );
    var editorDoc = processor.transformToDocument( xmlDoc );
    callback.call(this, xslTransform.serialize(editorDoc), this.editorid);
  };

  this.postProcess = function() {
    Ext.getCmp('editorTabPanel').getItem(UI.editor[editorid].tabid).doLayout();
    Ext.getCmp('editorTabPanel').getItem(UI.editor[editorid].tabid).editorid = editorid;
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

  this.getToolbar = function(editorid) {
    return MarceEditor.getToolbar(editorid);
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

  this.getControlNumber = function() {
    return this.xmldoc.getElementsByTagNameNS('http://purl.org/dc/elements/1.1/', 'identifier')[0].textContent;
  };
};
Ext.getCmp('searchgridUploadsBtn').menu.add(
  {
    text:'Dublin core',
    handler: function(btn){
      showUploadDialog('dublincore', 'uploadDC.pl', doUploadMarc);
    }
  }
);
Ext.getCmp('savegridUploadsBtn').menu.add(
  {
    text:'Dublin core',
    handler:
      function(btn){
        showUploadDialog('dublincore', 'uploadDC.pl', doUploadMarc);
      }
  }
);
